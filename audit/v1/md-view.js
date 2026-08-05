/* Minimal GFM-subset renderer for the audit deliverables.
   Renders headings, hr, blockquotes, GFM tables, ul/ol lists, and inline
   code / bold / italic / links. Used by findings.html and dev-handoff.html so
   the .md files stay the single source of truth (no static HTML to keep in sync).
   Deliberately small — not a full CommonMark parser; it only handles the
   constructs the audit .md files actually use. */
(function (global) {
  function esc(s) {
    return s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
  }
  // Inline formatting. Split on backticks so code-span content is never
  // reinterpreted (and no numeric placeholder can collide with real numbers).
  function inline(s) {
    var parts = s.split('`'), out = '';
    for (var k = 0; k < parts.length; k++) {
      if (k % 2 === 1) { out += '<code>' + esc(parts[k]) + '</code>'; continue; }
      var t = esc(parts[k]);
      t = t.replace(/\[([^\]]+)\]\(([^)\s]+)\)/g, '<a href="$2">$1</a>');
      t = t.replace(/\*\*([^*]+)\*\*/g, '<strong>$1</strong>');
      t = t.replace(/(^|[^*])\*([^*\s][^*]*?)\*(?!\*)/g, '$1<em>$2</em>');
      out += t;
    }
    return out;
  }
  function isSep(l) { return l.indexOf('-') > -1 && /^\s*\|?[\s:|-]+\|?\s*$/.test(l); }
  function row(r) {
    return r.replace(/^\s*\|/, '').replace(/\|\s*$/, '').split('|').map(function (c) { return c.trim(); });
  }
  function render(md) {
    var lines = md.replace(/\r\n/g, '\n').split('\n'), out = '', i = 0;
    function isTable(k) { return lines[k].indexOf('|') > -1 && k + 1 < lines.length && isSep(lines[k + 1]); }
    while (i < lines.length) {
      var l = lines[i];
      if (/^\s*$/.test(l)) { i++; continue; }
      var h = l.match(/^(#{1,6})\s+(.*)$/);
      if (h) { var n = h[1].length; out += '<h' + n + '>' + inline(h[2].trim()) + '</h' + n + '>'; i++; continue; }
      if (/^\s*(---+|\*\*\*+|___+)\s*$/.test(l)) { out += '<hr>'; i++; continue; }
      if (isTable(i)) {
        var header = row(l); i += 2; var rows = [];
        while (i < lines.length && lines[i].indexOf('|') > -1 && !/^\s*$/.test(lines[i])) { rows.push(row(lines[i])); i++; }
        var emptyH = header.every(function (c) { return c === ''; });
        var t = '<table>';
        if (!emptyH) { t += '<thead><tr>' + header.map(function (c) { return '<th>' + inline(c) + '</th>'; }).join('') + '</tr></thead>'; }
        t += '<tbody>' + rows.map(function (r) {
          return '<tr>' + r.map(function (c) { return '<td>' + inline(c) + '</td>'; }).join('') + '</tr>';
        }).join('') + '</tbody></table>';
        out += t; continue;
      }
      if (/^\s*>/.test(l)) {
        var bq = [];
        while (i < lines.length && /^\s*>/.test(lines[i])) { bq.push(lines[i].replace(/^\s*>\s?/, '')); i++; }
        out += '<blockquote>' + render(bq.join('\n')) + '</blockquote>'; continue;
      }
      if (/^\s*[-*]\s+/.test(l) || /^\s*\d+\.\s+/.test(l)) {
        var ordered = /^\s*\d+\.\s+/.test(l), tag = ordered ? 'ol' : 'ul',
            re = ordered ? /^\s*\d+\.\s+/ : /^\s*[-*]\s+/, li = '';
        while (i < lines.length && re.test(lines[i])) { li += '<li>' + inline(lines[i].replace(re, '')) + '</li>'; i++; }
        out += '<' + tag + '>' + li + '</' + tag + '>'; continue;
      }
      var pbuf = [];
      while (i < lines.length && !/^\s*$/.test(lines[i]) && !/^#{1,6}\s/.test(lines[i]) && !/^\s*>/.test(lines[i])
             && !isTable(i) && !/^\s*(---+|\*\*\*+|___+)\s*$/.test(lines[i])
             && !/^\s*[-*]\s+/.test(lines[i]) && !/^\s*\d+\.\s+/.test(lines[i])) {
        pbuf.push(lines[i]); i++;
      }
      out += '<p>' + inline(pbuf.join(' ')) + '</p>';
    }
    return out;
  }
  global.renderMarkdownDoc = function (mdPath, mountId) {
    var mount = document.getElementById(mountId || 'doc');
    fetch(mdPath)
      .then(function (r) { if (!r.ok) throw new Error('HTTP ' + r.status); return r.text(); })
      .then(function (md) { mount.innerHTML = render(md); })
      .catch(function (e) {
        mount.innerHTML = '<p class="status">Could not load <code>' + mdPath + '</code> (' + e.message +
          '). It sits next to this page &mdash; open it directly if needed.</p>';
      });
  };
  global.renderMarkdown = render; // exposed for testing
})(window);

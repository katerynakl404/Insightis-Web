/* Insightis attention-heatmap engine.
   A page supplies window.HM = {img, W, H, fold, points:[{x,y,r,w}], weak:[{x,y,w,h,sev,label,detail}], stats, notes:[]}.
   Coordinates are fractions of the full-page screenshot (0..1). */
(function () {
  var HM = window.HM;
  if (!HM) return;

  var SEV = { high: '#ff2d2d', med: '#ff7a00', low: '#20c9c0' };
  var SEVCLASS = { high: 's-high', med: 's-med', low: 's-low' };

  function ramp(t) {
    var s = [[0,[43,61,214]],[0.25,[31,182,230]],[0.5,[47,208,122]],[0.72,[245,209,0]],[0.88,[255,122,0]],[1,[255,45,45]]];
    for (var i = 1; i < s.length; i++) if (t <= s[i][0]) {
      var a = s[i-1], b = s[i], f = (t - a[0]) / (b[0] - a[0]);
      return [a[1][0]+(b[1][0]-a[1][0])*f, a[1][1]+(b[1][1]-a[1][1])*f, a[1][2]+(b[1][2]-a[1][2])*f];
    }
    return s[s.length-1][1];
  }

  var canvas = document.getElementById('hm'), ctx = canvas.getContext('2d');
  var img = new Image();
  var state = { heat: true, weak: true };

  function drawHeat(W, H) {
    var sc = 0.5, sw = Math.max(1, Math.round(W*sc)), sh = Math.max(1, Math.round(H*sc));
    var s = document.createElement('canvas'); s.width = sw; s.height = sh;
    var g = s.getContext('2d'); g.globalCompositeOperation = 'lighter';
    HM.points.forEach(function (p) {
      var cx = p.x*sw, cy = p.y*sh, rad = Math.max(6, p.r*W*sc);
      var rg = g.createRadialGradient(cx, cy, 0, cx, cy, rad);
      rg.addColorStop(0, 'rgba(0,0,0,' + p.w + ')'); rg.addColorStop(1, 'rgba(0,0,0,0)');
      g.fillStyle = rg; g.beginPath(); g.arc(cx, cy, rad, 0, 7); g.fill();
    });
    var id = g.getImageData(0, 0, sw, sh), d = id.data;
    for (var i = 0; i < d.length; i += 4) {
      var a = d[i+3]; if (!a) continue;
      var t = Math.min(1, a/255), c = ramp(t);
      d[i]=c[0]; d[i+1]=c[1]; d[i+2]=c[2]; d[i+3] = Math.round(Math.min(1, t*1.2)*200);
    }
    g.putImageData(id, 0, 0);
    ctx.imageSmoothingEnabled = true;
    ctx.drawImage(s, 0, 0, W, H);
  }

  function drawWeak(W, H) {
    var lw = Math.max(2, W*0.0016), badge = Math.max(24, W*0.02);
    ctx.font = '700 ' + Math.round(badge*0.6) + 'px ui-monospace,Menlo,Consolas,monospace';
    ctx.textAlign = 'center'; ctx.textBaseline = 'middle';
    HM.weak.forEach(function (z, i) {
      var x = z.x*W, y = z.y*H, w = Math.max(z.w*W, badge), h = Math.max(z.h*H, 8), col = SEV[z.sev] || SEV.low;
      ctx.strokeStyle = col; ctx.lineWidth = lw;
      ctx.fillStyle = col.replace(')', '') ; // not used; fill via rgba below
      ctx.globalAlpha = 0.10; ctx.fillStyle = col; ctx.fillRect(x, y, w, h);
      ctx.globalAlpha = 1; ctx.strokeRect(x, y, w, h);
      // badge
      var bx = x + badge*0.55, by = y + badge*0.55;
      ctx.beginPath(); ctx.arc(bx, by, badge*0.55, 0, 7); ctx.fillStyle = col; ctx.fill();
      ctx.fillStyle = '#fff'; ctx.fillText(String(i+1), bx, by+1);
    });
    ctx.globalAlpha = 1;
  }

  function render() {
    var W = HM.W, H = HM.H;
    canvas.width = W; canvas.height = H;
    ctx.clearRect(0, 0, W, H);
    if (img.complete && img.naturalWidth) ctx.drawImage(img, 0, 0, W, H);
    if (state.heat) drawHeat(W, H);
    if (state.weak) drawWeak(W, H);
  }

  // ---------- side panel ----------
  function buildPanel() {
    var st = HM.stats || {};
    var chips = document.getElementById('stats');
    if (chips) {
      var parts = [];
      if (st.screens) parts.push(['', st.screens + ' екранів']);
      if (st.cta) parts.push(['', st.cta + ' CTA']);
      var hi = HM.weak.filter(function(w){return w.sev==='high'}).length;
      var me = HM.weak.filter(function(w){return w.sev==='med'}).length;
      if (hi) parts.push(['hi', hi + ' критичних']);
      if (me) parts.push(['me', me + ' середніх']);
      var lo = HM.weak.length - hi - me; if (lo) parts.push(['', lo + ' дрібних']);
      chips.innerHTML = parts.map(function(p){return '<span class="chip '+p[0]+'">'+p[1]+'</span>'}).join('');
    }
    var list = document.getElementById('findings');
    if (list) {
      list.innerHTML = HM.weak.map(function (z, i) {
        return '<li class="finding ' + (SEVCLASS[z.sev]||'s-low') + '" data-i="' + i + '">' +
          '<span class="n">' + (i+1) + '</span><span class="b">' +
          '<span class="tt">' + esc(z.label) + '</span>' +
          '<span class="dd">' + esc(z.detail) + '</span></span></li>';
      }).join('');
      list.querySelectorAll('.finding').forEach(function (el) {
        el.addEventListener('click', function () { focusZone(HM.weak[+el.dataset.i]); });
      });
    }
    var notes = document.getElementById('notes');
    if (notes && HM.notes && HM.notes.length)
      notes.innerHTML = HM.notes.map(function (n) { return '<div class="note">' + esc(n) + '</div>'; }).join('');
  }

  function focusZone(z) {
    var stage = document.querySelector('.stage');
    var scale = canvas.clientWidth / HM.W;               // displayed px per natural px
    var target = (z.y + z.h/2) * HM.H * scale - stage.clientHeight/2;
    stage.scrollTo({ top: Math.max(0, target), behavior: 'smooth' });
  }

  function esc(s) { return String(s == null ? '' : s).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;'); }

  // toggles
  var th = document.getElementById('t-heat'), tw = document.getElementById('t-weak');
  if (th) th.addEventListener('change', function (e) { state.heat = e.target.checked; render(); });
  if (tw) tw.addEventListener('change', function (e) { state.weak = e.target.checked; render(); });

  img.onload = render;
  img.src = HM.img;
  buildPanel();
})();

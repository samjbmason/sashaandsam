import $ from 'jquery'

var COLORS, Confetti, NUM_CONFETTI, PI_2, canvas, confetti, context, drawCircle, i, range, resizeWindow, xpos;

NUM_CONFETTI = 80;

COLORS = [[124, 255, 203], [255, 220, 0], [246, 151, 121]];

PI_2 = 2 * Math.PI;

canvas = $('.confetti')[0];

context = canvas.getContext("2d");

window.w = 0;

window.h = 0;

resizeWindow = function() {
  window.w = canvas.width = window.innerWidth;
  return window.h = canvas.height = $(document).height();
};

window.addEventListener('resize', resizeWindow, false);

window.onload = function() {
  return setTimeout(resizeWindow, 0);
};

range = function(a, b) {
  return (b - a) * Math.random() + a;
};

drawCircle = function(x, y, side, style) {
  var h;
  h = side * (Math.sqrt(3) / 2);
  context.beginPath();
  context.moveTo(x, y + (-h / 2));
  context.lineTo(x + (-side / 2), y + (h / 2));
  context.lineTo(x + (side / 2), y + (h / 2));
  context.closePath();
  context.strokeStyle = style;
  context.lineWidth = 1;
  return context.stroke();
};

xpos = 0.5;

window.requestAnimationFrame = (function() {
  return window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame || function(callback) {
    return window.setTimeout(callback, 1000 / 60);
  };
})();

Confetti = (function() {
  function Confetti() {
    this.style = COLORS[~~range(0, 3)];
    this.side = 10;
    this.rgb = "rgba(" + this.style[0] + "," + this.style[1] + "," + this.style[2];
    this.r = ~~range(2, 4);
    this.r2 = 2 * this.r;
    this.replace();
  }

  Confetti.prototype.replace = function() {
    this.opacity = 0;
    this.dop = 0.03 * range(1, 2);
    this.x = range(-this.r2, w - this.r2);
    this.y = range(-20, h - this.r2);
    this.xmax = w - this.r;
    this.ymax = h - this.r;
    this.vx = range(0, 2) + 8 * xpos - 5;
    return this.vy = 0.4 * this.r + range(0, 1);
  };

  Confetti.prototype.draw = function() {
    var ref;
    this.x += this.vx;
    this.y += this.vy;
    this.opacity += this.dop;
    if (this.opacity > 1) {
      this.opacity = 1;
      this.dop *= -0.1;
    }
    if (this.opacity < 0 || this.y > this.ymax) {
      this.replace();
    }
    if (!((0 < (ref = this.x) && ref < this.xmax))) {
      this.x = (this.x + this.xmax) % this.xmax;
    }
    return drawCircle(~~this.x, ~~this.y, this.side, this.rgb + "," + this.opacity + ")");
  };

  return Confetti;

})();

confetti = (function() {
  var j, ref, results;
  results = [];
  for (i = j = 1, ref = NUM_CONFETTI; 1 <= ref ? j <= ref : j >= ref; i = 1 <= ref ? ++j : --j) {
    results.push(new Confetti);
  }
  return results;
})();

window.step = function() {
  var c, j, len, results;
  requestAnimationFrame(step);
  context.clearRect(0, 0, w, h);
  results = [];
  for (j = 0, len = confetti.length; j < len; j++) {
    c = confetti[j];
    results.push(c.draw());
  }
  return results;
};

step();

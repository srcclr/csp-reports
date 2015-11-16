function ChartGraph(canvas, options) {
  this.options = options;
  this.context = canvas.getContext('2d');
  this.canvas = canvas;
  this.reports = options.reports || [];
  this.xOffset = 30;
  this.yOffset = 30;
  this.dateStep = (canvas.width - this.xOffset * 2) / (this.reports.length);
  this.countStep = (canvas.height - this.yOffset * 2) / this.maxCount();
}

ChartGraph.prototype.maxCount = function() {
  let max = -1;

  this.reports.forEach((report, index) => {
    if (report[1] > max) {
      max = report[1];
    }
  })

  return max + 1;
}

ChartGraph.prototype.dotXCoord = function(index) {
  return this.dateStep * index + this.xOffset;
}

ChartGraph.prototype.dotYCoord = function(index) {
  return this.canvas.height - this.yOffset - this.reports[index][1] * this.countStep;
}

ChartGraph.prototype.clear = function(ctx) {
  return ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);
}

ChartGraph.prototype.drawAxis = function(ctx) {
  ctx.beginPath();
  ctx.moveTo(this.xOffset, this.yOffset);
  ctx.lineTo(this.xOffset, this.canvas.height - this.yOffset);

  for (let i = 0; i < this.maxCount() + 1; i++) {
    ctx.moveTo(this.xOffset, this.canvas.height - this.yOffset - this.countStep * i);
    ctx.font = "18px Arial";
    ctx.fillText(i, 0, this.canvas.height - this.yOffset - this.countStep * i + 9);
    ctx.lineTo(this.canvas.width - this.xOffset, this.canvas.height - this.yOffset - this.countStep * i);
  }

  ctx.strokeStyle = "grey";
  ctx.stroke();
}

ChartGraph.prototype.drawReportDots = function(ctx) {
  this.reports.forEach((report, index) => {
    ctx.beginPath();
    ctx.arc(this.dotXCoord(index), this.dotYCoord(index), 5, 0, 2 * Math.PI, false);
    ctx.fillStyle = "blue";
    ctx.fill();
  })
}

ChartGraph.prototype.drawReportLines = function(ctx) {
  this.reports.forEach((report, index) => {
    if (index < this.reports.length - 1) {
      ctx.beginPath();
      ctx.moveTo(this.dotXCoord(index), this.dotYCoord(index));
      ctx.lineTo(this.dotXCoord(index + 1), this.dotYCoord(index + 1));
      ctx.lineWidth = 3;
      ctx.strokeStyle = "blue";
      ctx.stroke();
    }
  })
}

ChartGraph.prototype.drawDates = function(ctx) {
  ctx.beginPath();

  this.reports.forEach((report, index) => {
    ctx.font = "18px Arial";
    ctx.fillStyle = "grey";
    ctx.fillText(report[0], this.dateStep * index + this.xOffset - 25, this.canvas.height - this.yOffset + 18);
  })
}

ChartGraph.prototype.draw = function() {
  let ctx = this.context;

  this.clear(ctx);
  this.drawAxis(ctx);
  this.drawReportDots(ctx);
  this.drawReportLines(ctx);
  this.drawDates(ctx);
}

export default ChartGraph;

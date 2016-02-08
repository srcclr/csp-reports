import Report from './report'

let GraphReport = Report.extend({})

GraphReport.reopenClass({
  createList(json) {
    return _.map(json.reports, (report) => { return this.createFromJson(report); });
  }
});

export default GraphReport;

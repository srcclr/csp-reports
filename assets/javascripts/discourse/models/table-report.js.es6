import Report from './report'

let TableReport = Report.extend({})

TableReport.reopenClass({
  createList(json) {
    return {
      reports: _.map(json.reports, (report) => { return this.createFromJson(report); }),
      meta: json.meta
    }
  }
});

export default TableReport;

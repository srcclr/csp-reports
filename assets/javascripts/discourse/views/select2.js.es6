export default Ember.Select.reopen({
  disabled: Em.computed.equal('content.length', 0),

  selectedDidChange: Em.observer('selection.@each', function() {
    this.$().select2('val', this.$().val());
  }),

  didInsertElement: function() {
    Ember.run.scheduleOnce('afterRender', this, 'processChildElements');
  },

  processChildElements: function() {
    var options = {
      allowClear: true,
      closeOnSelect: true,
      width: '200px'
    };

    this.$().select2(options);
  },

  willDestroyElement: function () {
    this.$().select2('destroy');
  }
});

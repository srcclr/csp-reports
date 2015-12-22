export default Ember.Select.reopen({

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
  },

  selectedDidChange: function() {
    this.$().select2('val', this.$().val());
  }.observes('selection.@each')
});

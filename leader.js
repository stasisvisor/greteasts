function createObservable() {
  const observers = [];
  return {
    subscribe: function(fn) {
      observers.push(fn);
    },
    notify: function(data) {
      observers.forEach(fn => fn(data));
    }
  };
}
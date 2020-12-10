import NotifComponent from '../components/notification.vue';

function Notification() {}

Notification.install = function (Vue) {
  const NotificationConstructor = Vue.extend(NotifComponent);
  let seed = 1;
  let curInstance;

  Vue.prototype.$notify = (options) => {
    const instance = new NotificationConstructor({
      data: options,
    });
    instance.id = `notification_${seed++}`;
    instance.$mount();
    if (curInstance) document.body.removeChild(curInstance.$el);
    document.body.appendChild(instance.$el);
    curInstance = instance;
    instance.visible = true;
    instance.dom = instance.$el;

    return instance;
  };
};

export default Notification;

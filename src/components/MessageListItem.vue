<template>
  <ion-item :detail="false" class="list-item" @click="onConnect">
    <ion-label class="ion-text-wrap ion-align-items-center">
      <h2>
        Device Name: {{ message[0] }}
      </h2>
      <h3>UUID: {{ message[1] }}</h3>
      <h3>Battery: {{ message[3] }}</h3>
      <p>
        Status: {{ message[2] === "true" ? "Connected" : "Not connected" }}
      </p>
    </ion-label>
  </ion-item>
</template>

<script lang="ts">
import {IonItem, IonLabel} from '@ionic/vue';
import {chevronForward} from 'ionicons/icons';
import {defineComponent} from 'vue';

export default defineComponent({
  name: 'MessageListItem',
  components: {
    IonItem,
    IonLabel,
  },
  props: ['message'],
  methods: {
    isIos: () => {
      const win = window as any;
      return win && win.Ionic && win.Ionic.mode === 'ios';
    },
    onConnect() {
      this.$emit('connect', this.message[1])
    }
  },
  data() {
    return {chevronForward}
  }
});
</script>

<style scoped>
.list-item {
  --padding-start: 0;
  --inner-padding-end: 0;
}

.list-item ion-label {
  margin-top: 12px;
  margin-bottom: 12px;
}

.list-item h2 {
  font-weight: 600;
  margin: 0;
}

.list-item p {
  text-overflow: ellipsis;
  overflow: hidden;
  white-space: nowrap;
  width: 95%;
}

.list-item .date {
  float: right;
  align-items: center;
  display: flex;
}

.list-item ion-icon {
  color: #c9c9ca;
}

.list-item ion-note {
  font-size: 15px;
  margin-right: 8px;
  font-weight: normal;
}

.list-item ion-note.md {
  margin-right: 14px;
}

.list-item .dot {
  display: block;
  height: 12px;
  width: 12px;
  border-radius: 50%;
  align-self: start;
  margin: 16px 10px 16px 16px;
}

.list-item .dot-unread {
  background: var(--ion-color-primary);
}
</style>
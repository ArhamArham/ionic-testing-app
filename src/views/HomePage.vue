<template>
  <ion-page>
    <ion-header :translucent="true">
      <ion-toolbar>
        <ion-title>Inbox</ion-title>
      </ion-toolbar>
    </ion-header>

    <ion-content :fullscreen="true">
      <ion-refresher slot="fixed" @ionRefresh="refresh($event)">
        <ion-refresher-content></ion-refresher-content>
      </ion-refresher>

      <ion-button @click="getEchoCall">
        getEchoCall
      </ion-button>

      <ion-button @click="getConnectionManager">
        Get Connection Manager
      </ion-button>

      <ion-button @click="getConnectionViewWillDisappear">
        Get Connection View Will Disappear
      </ion-button>

      <ion-button @click="getScanDevices">
        Get Scan Devices
      </ion-button>

      <ion-header collapse="condense">
        <ion-toolbar>
          <ion-title size="large">Inbox</ion-title>
        </ion-toolbar>
      </ion-header>

      <ion-list>
        <MessageListItem v-for="message in messages" :key="message.id" :message="message"/>
      </ion-list>
    </ion-content>
  </ion-page>
</template>

<script lang="ts">
import {
  IonContent,
  IonHeader,
  IonList,
  IonPage,
  IonRefresher,
  IonRefresherContent,
  IonTitle,
  IonToolbar,
  IonButton
} from '@ionic/vue';
import MessageListItem from '@/components/MessageListItem.vue';
import {defineComponent} from 'vue';
import {getMessages} from '@/data/messages';
import {XSense} from '@capacitor/xsense';

export default defineComponent({
  name: 'HomePage',
  data() {
    return {
      messages: getMessages(),
      int1: 0,
      int2: 0,
      answer: ""
    }
  },
  methods: {
    refresh: (ev: CustomEvent) => {
      setTimeout(() => {
        ev.detail.complete();
      }, 3000);
    },
    async getEchoCall() {
      let res = await XSense.echo({value: 'Hello from demo'});
      console.log('got response from XSense.echo', JSON.stringify(res));
    },
    async getConnectionManager() {
      let res = await XSense.connectionManager();
      console.log('got response from XSense.connectionManager', JSON.stringify(res));
    },
    async getConnectionViewWillDisappear() {
      let res = await XSense.CoonectionviewWillDisappear();
      console.log('got response from XSense.CoonectionviewWillDisappear', JSON.stringify(res));
    },
    async getScanDevices() {
      let res = await XSense.scanDevices();
      console.log('got response from XSense.scanDevices', JSON.stringify(res));
    }
  },
  components: {
    IonContent,
    IonHeader,
    IonList,
    IonPage,
    IonRefresher,
    IonRefresherContent,
    IonTitle,
    IonToolbar,
    MessageListItem,
    IonButton
  },
});
</script>

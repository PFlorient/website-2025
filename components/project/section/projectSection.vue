<template>
  <nuxt-link :to="`/${props.title}`" @click="console.log('test')"
    ><div
      class="section-link"
      :class="{ inverted: inverted, active: isActive }"
    >
      <section
        ref="sectionRef"
        :class="[
          'relative flex w-screen h-screen cursor-pointer overflow-hidden',
          inverted ? 'flex-row-reverse' : '',
        ]"
      >
        <!-- Conteneur pour le texte -->
        <div
          ref="leftRef"
          class="text-container absolute top-0 h-full flex items-end p-8 bg-secondary z-10"
          :class="[
            'w-1/2',
            inverted
              ? 'right-0'
              : 'left-0' /* Position correcte selon inverted */,
          ]"
        >
          <h2 ref="textH2" class="text-6xl font-bold font-neueMetana">
            {{ title }}
          </h2>
        </div>

        <!-- Image -->
        <img
          ref="rightRef"
          class="absolute top-0 h-full object-cover z-0"
          :class="[
            'w-1/2',
            inverted
              ? 'left-0'
              : 'right-0' /* Position correcte selon inverted */,
          ]"
          src="https://picsum.photos/200/300"
          alt=""
        />
      </section></div
  ></nuxt-link>
</template>

<script setup lang="ts">
import { gsap } from "gsap";

const props = defineProps<{
  title: string;
  img: string;
  animation?: boolean;
  inverted?: boolean;
  isActive?: boolean;
}>();

const sectionRef = ref<HTMLElement | null>(null);
const leftRef = ref<HTMLElement | null>(null);
const textH2 = ref<HTMLElement | null>(null);

onMounted(() => {
  if (leftRef.value) {
    gsap.from(leftRef.value, {
      duration: 0.7,
      width: "100%",
      height: "100%",
      ease: "power2.out",
    });
    gsap.from(textH2.value, {
      duration: 0.3,
      clipPath: "inset(0 0 0 100%)",
      ease: "none",
    });
  }
});

onBeforeRouteLeave((to, from, next) => {
  if (!props.isActive) return next();
  if (leftRef.value) {
    gsap.to(leftRef.value, {
      duration: 0.7,
      width: "100%",
      height: "100%",
      ease: "power2.out",
      onComplete: () => {
        next();
      },
    });
    gsap.to(textH2.value, {
      duration: 0.3,
      clipPath: "inset(0 0 0 100%)",
      ease: "none",
    });
  }
});
</script>

<style>
.section-link {
  overflow: hidden; /* Empêche les débordements lors des animations */
}
</style>

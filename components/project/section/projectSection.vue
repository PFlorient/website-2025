<template>
  <NuxtLink class="section-link" :to="`/${title}`">
    <section
      ref="sectionRef"
      :class="[
        'flex w-screen h-screen cursor-pointer',
        { 'flex-row-reverse': inverted },
      ]"
    >
      <h2 ref="leftRef" class="w-1/2 flex items-end text-6xl font-bold p-8">
        {{ title }}
      </h2>

      <img
        ref="rightRef"
        class="w-1/2"
        src="https://picsum.photos/200/300"
        alt=""
      />
    </section>
  </NuxtLink>
</template>

<script setup lang="ts">
import { gsap } from "gsap";
import ScrollTrigger from "gsap/ScrollTrigger";

gsap.registerPlugin(ScrollTrigger);

defineProps<{
  title: string;
  img: string;
  inverted?: boolean;
}>();

const sectionRef = ref<HTMLElement | null>(null);
const leftRef = ref<HTMLElement | null>(null);
const rightRef = ref<HTMLElement | null>(null);
onMounted(() => {
  if (sectionRef.value && leftRef.value && rightRef.value) {
    // Animation GSAP
    gsap.fromTo(
      leftRef.value,
      { y: "-100%", opacity: 0 },
      {
        y: "0%",
        opacity: 1,
        scrollTrigger: {
          trigger: sectionRef.value,
          start: "top bottom", // Start lorsque la section entre dans le viewport
          end: "center center", // Fin lorsque la section est centrée
          scrub: true, // Synchronise avec le scroll
        },
      }
    );

    gsap.fromTo(
      rightRef.value,
      { y: "100%", opacity: 0 },
      {
        y: "0%",
        opacity: 1,
        scrollTrigger: {
          trigger: sectionRef.value,
          start: "top bottom",
          end: "center center",
          scrub: true,
        },
      }
    );
  }
});
</script>

<style></style>

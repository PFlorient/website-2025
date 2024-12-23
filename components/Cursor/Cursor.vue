<template>
  <div>
    <div ref="cursor" class="cursor" :class="{ 'is-point': isOverLink }">
      <div ref="dot" class="cursor-point"></div>
      <span v-show="!isOverLink" class="cursor-text">{{ text }}</span>
    </div>
  </div>
</template>

<script setup lang="ts">
import { gsap } from "gsap";

const route = useRoute();
const text = computed(() => (route.fullPath === "/" ? "click" : "retour"));

const cursor = ref<HTMLDivElement | null>(null);
const dot = ref<HTMLDivElement | null>(null);
const isOverLink = ref(false);

onMounted(() => {
  const cursorEl = cursor.value;
  if (!cursorEl) return;

  // Ensure the cursor is positioned properly
  gsap.set(cursorEl, { xPercent: -50, yPercent: -50 });

  // Function to update cursor position
  const onMouseMove = (e: MouseEvent) => {
    const { clientX: x, clientY: y } = e;

    // Move the cursor quickly
    gsap.to(cursorEl, {
      duration: 0,
      x,
      y,
      ease: "power2.out",
    });
  };

  // Detect if the cursor is over a link
  const onMouseOver = (e: MouseEvent) => {
    if ((e.target as HTMLElement).tagName === "A") {
      isOverLink.value = true;
      gsap.to(dot.value, {
        duration: 0.5,
        scale: 2,
        ease: "bounce",
      });
    }
  };

  const onMouseOut = (e: MouseEvent) => {
    if ((e.target as HTMLElement).tagName === "A") {
      isOverLink.value = false;
      gsap.to(dot.value, {
        duration: 0.5,
        scale: 1,
        ease: "bounce",
      });
    }
  };

  // Attach event listeners
  window.addEventListener("mousemove", onMouseMove);
  window.addEventListener("mouseover", onMouseOver);
  window.addEventListener("mouseout", onMouseOut);

  // Cleanup the event listeners when the component is unmounted
  onBeforeUnmount(() => {
    window.removeEventListener("mousemove", onMouseMove);
    window.removeEventListener("mouseover", onMouseOver);
    window.removeEventListener("mouseout", onMouseOut);
  });
});
</script>

<style scoped>
.cursor {
  position: fixed;
  top: 0px;
  left: 0;
  z-index: 99;
  pointer-events: none;
  font-size: 20px;
  font-weight: bold;
  text-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
  transition: all 0.2s ease;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.cursor-point {
  width: 10px;
  height: 10px;
  background-color: var(--primary-color);
  border-radius: 50%;
}

.cursor-text {
  color: var(--primary-color);
  font-size: 14px;
  position: absolute;
  bottom: -40px;
}

.cursor.is-point .cursor-text {
  display: none;
}
</style>

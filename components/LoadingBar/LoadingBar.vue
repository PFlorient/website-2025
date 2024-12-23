<template>
  <div class="big-layout" ref="bigLayout">
    <div ref="loadingContainer" class="loading-container overflow-hidden">
      <div
        ref="dot1"
        class="w-[20px] h-[20px] bg-black rounded-full opacity-0 absolute bottom-full right-0"
      ></div>
      <div
        ref="dot2"
        class="w-[20px] h-[20px] bg-black rounded-full opacity-0 absolute bottom-full right-[40%]"
      ></div>
      <div ref="loadingBar" class="loading-bar"></div>
      <div>{{ progress }}%</div>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { gsap } from "gsap";

// Références pour les éléments DOM
const loadingContainer = ref<HTMLDivElement | null>(null);
const loadingBar = ref<HTMLDivElement | null>(null);
const dot1 = ref<HTMLDivElement | null>(null);
const dot2 = ref<HTMLDivElement | null>(null);
const bigLayout = ref<HTMLDivElement | null>(null);
const progress = ref(0);

onMounted(() => {
  const container = loadingContainer.value;
  const dot1El = dot1.value;
  const dot2El = dot2.value;
  const bar = loadingBar.value;
  const bigLayoutEl = bigLayout.value;
  if (!container || !bar) return;

  const timeline = gsap.timeline();

  // Fonction pour simuler ou suivre l'avancement du chargement
  const updateProgress = () => {
    const totalResources = performance.getEntriesByType("resource").length || 1;
    const loadedResources = performance
      .getEntriesByType("resource")
      .filter((res) => (res as PerformanceResourceTiming).responseEnd).length;
    progress.value = Math.min((loadedResources / totalResources) * 100, 100);

    // Animer la progression avec GSAP
    timeline.to(bar, {
      width: `${progress.value}%`,
      duration: 0.2,
      ease: "power2.easeOut",
    });

    if (progress.value === 100) {
      gsap.to(container, {
        delay: 0.3,
        rotate: -90,
        duration: 0.3,
        onComplete: () => {
          gsap.to(dot1El, {
            opacity: 1,
            bottom: "10%",
            duration: 0.7,
          });
          gsap.to(dot2El, {
            delay: 0.1,
            opacity: 1,
            bottom: "25%",
            duration: 0.6,
          });
          timeline.to(bigLayoutEl, {
            delay: 1,
            y: "-100%",
            duration: 0.8,
            ease: "power2.easeInOut",
            onComplete: () => (container.style.display = "none") as any,
          });
        },
      });
    }

    if (progress.value === 100) {
      // Animation de remontée immédiate après la barre complétée
    }
  };

  // Suivre les ressources en temps réel
  const interval = setInterval(() => {
    updateProgress();
    if (progress.value === 100) {
      clearInterval(interval);
    }
  }, 1);

  // Nettoyage des listeners
  window.addEventListener("load", updateProgress);
});
</script>

<style scoped></style>

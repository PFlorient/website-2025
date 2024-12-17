<template>
  <div class="container">
    <div class="flex w-full justify-between self-center">
      <h1 ref="textH1" class="text-7xl font-bold">salut</h1>
      <span ref="period">salut 2</span>
    </div>
    <p class="self-center" ref="description">
      Lorem ipsum dolor sit amet consectetur adipisicing elit. Similique
      quisquam expedita animi blanditiis fugiat consequuntur soluta atque esse
      eum labore vitae aspernatur impedit, nostrum deleniti voluptate dolores
      dolore tempora eos. Lorem ipsum dolor sit amet, consectetur adipisicing
      elit. Tempore rerum ratione vero veniam quisquam. Eligendi animi aliquam
      incidunt vitae itaque sit dolores quam, impedit repudiandae, saepe maxime
      quibusdam esse inventore. lorem Lorem ipsum dolor sit amet consectetur a
    </p>
    <div class="flex w-full justify-between gap-14">
      <div class="test w-full block bg-emerald-400 h-40"></div>
      <div class="test w-full block bg-emerald-400 h-40"></div>
      <div class="test w-full block bg-emerald-400 h-40"></div>
      <div class="test w-full block bg-emerald-400 h-40"></div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { gsap } from "gsap";
const textH1 = ref<HTMLElement | null>(null);
const period = ref<HTMLElement | null>(null);
const description = ref<HTMLElement | null>(null);

onMounted(() => {
  const timeline = gsap.timeline();

  // Définit l'état initial pour éviter tout flash visuel
  gsap.set([textH1.value, period.value, description.value], {
    clipPath: "inset(0 100% 0 0)", // Masquer initialement
  });

  gsap.set(".flex div", {
    opacity: 0, // Masquer les blocs initialement
    y: 100, // Positionner en dehors de la vue
  });

  // Lancer les animations
  if (textH1.value) {
    timeline
      .to([textH1.value, period.value], {
        duration: 0.5,
        clipPath: "inset(0 0% 0 0)", // Texte devient visible de haut en bas
        ease: "power1.inOut",
      })
      .to(description.value, {
        duration: 1,
        clipPath: "inset(0 0% 0 0)", // Texte devient visible de haut en bas
        ease: "power1.inOut",
      })
      .to(
        ".flex div",
        {
          opacity: 1, // Rendre visible
          y: 0, // Revenir à la position initiale
          duration: 0.5,
          stagger: 0.2, // Délai entre chaque bloc
        },
        "-=0.3"
      ); // Commencer légèrement avant la fin de l'animation précédente
  }
});
</script>

<style scoped>
h1,
span,
p {
  clip-path: inset(0 100% 0 0); /* Masque le texte de haut en bas */
}
</style>

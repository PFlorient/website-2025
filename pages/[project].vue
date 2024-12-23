<template>
  <div class="container">
    <div class="flex w-full justify-between flex-col lg:flex-row self-center">
      <h1 ref="textH1" class="text-4xl lg:text-7xl font-bold">
        {{ infoProject?.name }}
      </h1>
      <span ref="period">salut 2</span>
    </div>
    <p
      ref="description"
      class="self-center"
      v-html="infoProject?.description"
    ></p>
    <div
      class="flex w-full flex-wrap lg:flex-nowrap justify-around lg:justify-between items-center gap-7 lg:gap-14"
    >
      <img
        v-for="image in infoProject?.pictures"
        :key="image"
        :src="`/img/${infoProject?.name}/${image}`"
        alt=""
        class="object-contain w-[calc(50%_-_1rem)] lg:w-full"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import { gsap } from "gsap";
import { useProjectStore } from "../store/project";

const textH1 = ref<HTMLElement | null>(null);
const period = ref<HTMLElement | null>(null);
const description = ref<HTMLElement | null>(null);
const route = useRoute();
const projectStore = useProjectStore();
const currentProject = route.params.project;
const infoProject = projectStore.getProjectInfo(currentProject as string);
onMounted(() => {
  const timeline = gsap.timeline();

  // Définit l'état initial pour éviter tout flash visuel
  gsap.set([textH1.value, period.value, description.value], {
    clipPath: "inset(0 100% 0 0)", // Masquer initialement
  });

  gsap.set(".flex img", {
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
        ".flex img",
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

onBeforeRouteLeave((to, from, next) => {
  // Inverse l'animation lors du démontage du composant
  gsap.to([textH1.value, period.value, description.value], {
    clipPath: "inset(0 100% 0 0)", // Masquer le texte de bas en haut
    duration: 0.5,
    ease: "power1.inOut",
  });

  gsap.to(".flex img", {
    opacity: 0, // Masquer les blocs
    y: 100, // Descendre hors de la vue
    duration: 0.5,
    stagger: 0.2, // Délai entre chaque bloc
    onComplete: () => {
      next();
    },
  });
});
</script>

<style scoped>
h1,
span,
p {
  clip-path: inset(0 100% 0 0); /* Masque le texte de haut en bas */
}
</style>

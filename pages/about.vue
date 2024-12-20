<template>
  <div class="container-info">
    <div class="flex w-full justify-between self-end px-4 lg:px-28">
      <h1 ref="textH1" class="text-5xl font-bold">Hey moi c'est Florient !</h1>
    </div>
    <p ref="description" class="w-full lg:w-2/3 px-4 lg:px-28">
      Développeur Front-end basé à Lille, je suis spécialisé dans les frameworks
      JavaScript, avec une préférence pour TypeScript. J'aime créer différentes
      applications web modernes, dynamiques et intuitives, que ce soit en
      utilisant Vue, Nuxt, ou autres.<br /><br />
      N’hésitez pas à me contacter, que ce soit pour collaborer sur des projets
      personnels ou simplement échanger autour de nouvelles&nbsp;idées.<br />
      <br />
      Et lorsque je ne suis pas en train de développer, j'aime suivre les
      actualités jeux vidéoludiques, ainsi que pratiquer le
      jeu&nbsp;de&nbsp;rôle&nbsp;.
      <br />
      <br />
      Au plaisir d'un jour échanger avec vous !
    </p>
    <div class="flex w-full justify-between items-end p-4 font-neueMetana">
      <span
        ><a href="https://www.linkedin.com/in/florient-plouvin/" target="_blank"
          >LinkedIn</a
        >
        | <a href="" target="_blank">Github</a></span
      >
      <span>contact</span>
    </div>
  </div>
</template>

<script setup lang="ts">
import { gsap } from "gsap";

const textH1 = ref<HTMLElement | null>(null);
const description = ref<HTMLElement | null>(null);

onMounted(() => {
  const timeline = gsap.timeline();

  // Définit l'état initial pour éviter tout flash visuel
  gsap.set([textH1.value, description.value], {
    clipPath: "inset(0 100% 0 0)", // Masquer initialement
  });

  gsap.set(".flex div", {
    opacity: 0, // Masquer les blocs initialement
    y: 100, // Positionner en dehors de la vue
  });

  // Lancer les animations
  if (textH1.value) {
    timeline
      .to([textH1.value], {
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

onBeforeRouteLeave((to, from, next) => {
  // Inverse l'animation lors du démontage du composant
  gsap.to([textH1.value, description.value], {
    clipPath: "inset(0 100% 0 0)", // Masquer le texte de bas en haut
    duration: 0.5,
    ease: "power1.inOut",
  });

  gsap.to(".flex div", {
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
p {
  clip-path: inset(0 100% 0 0); /* Masque le texte de haut en bas */
}
</style>

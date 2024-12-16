<template>
  <div
    class="section-link"
    :class="{ inverted: inverted }"
    @click="handleClick"
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
        <h2 ref="textH2" class="text-6xl font-bold">
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
    </section>
  </div>
</template>

<script setup lang="ts">
import { gsap } from "gsap";
import { useRouter } from "vue-router";

const props = defineProps<{
  title: string;
  img: string;
  animation?: boolean;
  inverted?: boolean;
}>();

const sectionRef = ref<HTMLElement | null>(null);
const leftRef = ref<HTMLElement | null>(null);
const textH2 = ref<HTMLElement | null>(null);
const router = useRouter();

const handleClick = () => {
  if (leftRef.value) {
    // Animation pour agrandir la div texte
    gsap.to(leftRef.value, {
      duration: 0.5,
      width: "100%", // Étend la div texte à 100% de la largeur
      height: "100%", // Étend la div texte à toute la hauteur
      ease: "power2.out", // Léger ease-out sur la fin
      onComplete: () => {
        gsap.to(textH2.value, {
          duration: 0.1, // Animation rapide pour effacer le texte
          clipPath: "inset(0 0 0 100%)", // Masque le texte de gauche à droite
          ease: "none", // Pas d'effet d'accélération/décélération
          onComplete: () => {
            // Redirection après l'effacement
            router.push(`/${props.title}`);
          },
        });
      },
    });
  }
};
</script>

<style>
.section-link {
  overflow: hidden; /* Empêche les débordements lors des animations */
}
</style>

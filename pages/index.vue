<template>
  <div class="content">
    <div class="panel"><ProjectSection title="test" img="" /></div>
    <div class="panel">
      <ProjectSection
        title="test 2"
        img=""
        :animation="true"
        :inverted="true"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import { gsap } from "gsap";
import ScrollTrigger from "gsap/ScrollTrigger";

onMounted(() => {
  gsap.registerPlugin(ScrollTrigger);

  const panels = gsap.utils.toArray(".panel") as HTMLElement[];

  if (panels.length === 0) {
    console.error(
      "No panels found. Check if the `.panel` class exists in the DOM."
    );
    return;
  }

  // Stockez les triggers des panneaux
  const tops = panels.map((panel) =>
    ScrollTrigger.create({
      trigger: panel,
      start: "top top",
      invalidateOnRefresh: true, // Recalcul automatique
    })
  );

  // Ajoutez un ScrollTrigger à chaque panneau
  panels.forEach((panel) => {
    ScrollTrigger.create({
      trigger: panel,
      start: () =>
        panel.offsetHeight < window.innerHeight ? "top top" : "bottom bottom",
      pin: true,
      pinSpacing: false,
      invalidateOnRefresh: true, // Recalcul automatique si les dimensions changent
    });
  });

  // Snap logic
  ScrollTrigger.create({
    snap: {
      snapTo: (progress, self) => {
        // Vérifiez si `self.scroll` est défini
        if (!self?.scroll()) {
          console.warn("Scroll is undefined. Snapping is skipped.");
          return progress; // Retourne la progression actuelle pour éviter le snapping
        }

        // Recalculez les points de départ des panneaux
        const panelStarts = tops.map((st) => st.start);

        // Si tous les `panelStarts` sont à 0, ignorez le snapping
        if (panelStarts.every((start) => start === 0)) {
          console.warn("Panel starts are all 0. Skipping snapping.");
          return progress;
        }

        const currentScroll = self.scroll();
        const snapScroll = gsap.utils.snap(panelStarts, currentScroll);

        console.log("Current Scroll:", currentScroll);
        console.log("Snap Scroll:", snapScroll);

        return gsap.utils.normalize(
          0,
          ScrollTrigger.maxScroll(window),
          snapScroll
        );
      },
      duration: 0.5,
    },
  });

  // Rafraîchissez tout après initialisation
  ScrollTrigger.refresh();
});
</script>

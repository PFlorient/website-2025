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

gsap.registerPlugin(ScrollTrigger);

onMounted(() => {
  const panels = gsap.utils.toArray(".panel") as any;
  // we'll create a ScrollTrigger for each panel just to track when each panel's top hits the top of the viewport (we only need this for snapping)
  const tops = panels.map((panel: any) =>
    ScrollTrigger.create({ trigger: panel, start: "top top" })
  );

  panels.forEach((panel: any) => {
    ScrollTrigger.create({
      trigger: panel as any,
      start: () =>
        panel.offsetHeight < window.innerHeight ? "top top" : "bottom bottom", // if it's shorter than the viewport, we prefer to pin it at the top
      pin: true,
      pinSpacing: false,
    });
  });

  ScrollTrigger.create({
    snap: {
      snapTo: (progress, self) => {
        const panelStarts = tops.map((st: any) => st.start), // an Array of all the starting scroll positions. We do this on each scroll to make sure it's totally responsive. Starting positions may change when the user resizes the viewport
          snapScroll = gsap.utils.snap(panelStarts, self!.scroll()); // find the closest one
        return gsap.utils.normalize(
          0,
          ScrollTrigger.maxScroll(window),
          snapScroll
        ); // snapping requires a progress value, so convert the scroll position into a normalized progress value between 0 and 1
      },
      duration: 0.5,
    },
  });
});
</script>

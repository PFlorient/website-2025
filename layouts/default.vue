<template>
  <div>
    <LoadingBar />
    <Navbar />
    <NuxtPage />
    <Cursor v-if="!smallerThanLg" />
  </div>
</template>

<script setup lang="ts">
import { breakpointsTailwind, useBreakpoints } from "@vueuse/core";
const breakpoints = useBreakpoints(breakpointsTailwind);
const smallerThanLg = breakpoints.smaller("lg");
</script>

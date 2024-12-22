<template>
  <NuxtLayout>
    <RouterView />
  </NuxtLayout>
</template>

<script setup lang="ts">
import { useProjectStore } from "./store/project";

const projectStore = useProjectStore();
await projectStore.fetchProjects();
</script>

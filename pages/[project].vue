<template>
  <div>
    <br /><br /><br /><br /><br /><br /><br />
    {{ router.currentRoute.value.params.project }}
  </div>
</template>

<script setup lang="ts">
const router = useRouter();
</script>

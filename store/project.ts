import { defineStore } from "pinia";

interface Project {
  name: string;
  description: string;
  main_picture: string;
  pictures: string[];
}

export const useProjectStore = defineStore("project", {
  state: () => ({
    projects: [] as Project[],
  }),
  actions: {
    async fetchProjects() {
      try {
        const { data, error } = await useFetch<Project[]>("/api/projects");

        if (error.value || !data.value || !Array.isArray(data.value)) {
          this.projects = [];
          return;
        }

        this.projects = data.value;
      } catch (e) {
        console.error("Error api/projects", e);
        this.projects = [];
      }
    },
  },
  getters: {
    getProjects: (state) => {
      return state.projects.map((project) => {
        return {
          title: project.name,
          mainImage: project.main_picture,
          link: `/${project.name}`,
        };
      });
    },
    getProjectInfo: (state) => (title: string) =>
      state.projects.find((project) => project.name === title),
  },
});

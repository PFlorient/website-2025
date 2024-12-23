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
      const { data } = await useFetch("/api/projects");
      const projects = data.value as Project[];
      this.projects = projects;
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

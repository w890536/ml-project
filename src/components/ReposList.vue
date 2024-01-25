<template>
  <div>
    <ul>
      <li v-for="(repo, index) in repos" :key="repo.id" class="repo">
        {{ `第${index + 1}筆: ${repo.name}` }}
      </li>
    </ul>
    <div v-if="loading">Loading...</div>
    <div v-if="!hasMore">No more repositories to load.</div>
  </div>
</template>

<script>
import { ref, onMounted } from "vue";
import axios from "axios";

export default {
  name: "ReposList",
  setup() {
    const repos = ref([]);
    const loading = ref(false);
    const hasMore = ref(true);
    let page = 1;

    const loadRepos = async (perPage = 30) => {
      try {
        loading.value = true;
        const response = await axios.get(
          `https://api.github.com/users/521xueweihan/repos?page=${page}&per_page=${perPage}`
        );

        console.log("response?.data?.length ", response?.data?.length);

        if (response?.data?.length === 0) {
          hasMore.value = false;
        } else {
          repos.value = [...repos.value, ...response.data];
          page++;
        }
      } catch (error) {
        console.error("Error loading repos:", error);
      } finally {
        loading.value = false;
      }
    };

    const isBottomOfPage = () => {
      return window.innerHeight + window.scrollY >= document.body.offsetHeight;
    };

    window.onscroll = () => {
      if (isBottomOfPage() && !loading.value && hasMore.value) {
        loadRepos(10);
      }
    };

    onMounted(() => {
      loadRepos(30);
    });

    return { repos, loading, hasMore };
  },
};
</script>

<style lang="scss" scoped>
.repo {
  font-size: 30px;
}
</style>

import { login, logout, getInfo, refresh } from "@/api/user";
import { getToken, getRefresh, setToken, setRefresh, removeToken, removeRefresh } from "@/utils/auth";
// ! TODO
import { resetRouter } from "@/router";
import router from "@/router"

const getDefaultState = () => {
  return {
    token: getToken(),
    name: null,
    user_id: null,
    refresh_token: getRefresh(),
  };
};

const state = getDefaultState();

const mutations = {
  RESET_STATE: (state) => {
    Object.assign(state, getDefaultState());
  },
  SET_TOKEN: (state, token) => {
    state.token = token;
  },
  SET_NAME: (state, name) => {
    state.name = name;
  },
  SET_ID: (state, id) => {
    state.user_id = id;
  },
  SET_REFRESH: (state, refreshToken) => {
    state.refresh_token = refreshToken;
  }
};

const actions = {
  // user login
  // login({ commit }, userInfo) {
  //   const { username, password } = userInfo;
  //   return new Promise((resolve, reject) => {
  //     login({ username: username.trim(), password: password })
  //       .then((response) => {
  //         // const { data } = response;
  //         commit("SET_TOKEN", "Bearer " + response.token);
  //         setToken("Bearer " + response.token);
  //         resolve();
  //       })
  //       .catch((error) => {
  //         reject(error);
  //       });
  //   });
  // },

  login({ commit }, ticket) {
    return new Promise((resolve, reject) => {
      login(ticket)
        .then((response) => {
          // const { data } = response;
          commit("SET_TOKEN", "Bearer " + response.access);
          commit("SET_REFRESH", response.refresh);
          setToken("Bearer " + response.access);
          setRefresh(response.refresh);
          resolve();
        })
        .catch((error) => {
          reject(error);
        });
    });
  },

  // get user info
  getInfo({ commit }) {
    return new Promise((resolve, reject) => {
      getInfo()
        .then((response) => {
          // const { data } = response
          // if (!data) {
          //   return reject('Verification failed, please Login again.')
          // }
          // const { name, avatar } = data
          // commit('SET_NAME', name)
          // commit('SET_AVATAR', avatar)
          // resolve(data)
          const name = response.user_detail.nickname;
          const user_id = response.user_detail.related_user;
          commit("SET_NAME", name);
          commit("SET_ID", user_id);
          resolve();
        })
        .catch((error) => {
          reject(error);
        });
    });
  },
  setInfo({ commit }, name) {
    commit("SET_NAME", name);
  },
  // user logout
  logout({ commit, state }) {
    return new Promise((resolve, reject) => {
      logout(state.refresh_token)
        .then(() => {
          removeToken(); // must remove  token  first
          resetRouter();
          commit("RESET_STATE");
          resolve();
        })
        .catch((error) => {
          reject(error);
        });
    });
  },

  refreshToken({ commit, state }) {
    return new Promise((resolve, reject) => {
      refresh(state.refresh_token).then((resp) => {
        commit("SET_TOKEN", "Bearer " + resp.access);
        setToken("Bearer " + resp.access);
        router.go();
        resolve();
      }).catch((error) => {
        removeToken();
        removeRefresh();
        commit("RESET_STATE");
        router.go();
        reject(error);
      })
    })
  }
};


export default {
  namespaced: true,
  state,
  mutations,
  actions,
};

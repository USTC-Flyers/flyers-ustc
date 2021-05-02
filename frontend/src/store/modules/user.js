import { login, logout, getInfo } from "@/api/user";
import { getToken, setToken, removeToken } from "@/utils/auth";
// ! TODO
import { resetRouter } from "@/router";

const getDefaultState = () => {
  return {
    token: getToken(),
    name: null,
    user_id: 1,
    avatar: null,
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
  SET_AVATAR: (state, avatar) => {
    state.avatar = avatar;
  },
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
          setToken("Bearer " + response.access);
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
          console.log(name);
          commit("SET_NAME", name);
          resolve();
        })
        .catch((error) => {
          reject(error);
        });
    });
  },
  setInfo({ commit }, name){
    commit("SET_NAME", name);
  },
  // user logout
  logout({ commit, state }) {
    return new Promise((resolve, reject) => {
      logout(state.token)
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

  // remove token
  resetToken({ commit }) {
    return new Promise((resolve) => {
      removeToken(); // must remove  token  first
      commit("RESET_STATE");
      resolve();
    });
  },
};

export default {
  namespaced: true,
  state,
  mutations,
  actions,
};

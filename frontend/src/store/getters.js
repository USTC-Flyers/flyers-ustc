const getters = {
  sidebar: (state) => state.app.sidebar,
  device: (state) => state.app.device,
  token: (state) => state.user.token,
  name: (state) => state.user.name,
  user_id: (state) => state.user.user_id,
  refresh_token: (state) => state.user.refresh_token,
};
export default getters;

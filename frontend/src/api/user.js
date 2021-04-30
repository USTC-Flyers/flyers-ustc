import request from "@/utils/request";

export function login(ticket) {
  return request({
    url: "/login/",
    method: "get",
    params: { ticket },
  });
}

export function getInfo() {
  return request({
    url: "/user_profile/user_detail/",
    method: "get",
    // params: { token }
  });
}
export function create_user_profile(data) {
  return request({
    url: "/user_profile/",
    method: "post",
    data,
  });
}
export function update_user_profile(id, data) {
  return request({
    url: `/user_profile/${id}/`,
    method: "put",
    data,
  });
}
export function update_contact(id, data) {
  return request({
    url: `/user_profile/${id}/`,
    method: "patch",
    data,
  });
}
export function logout() {
  return request({
    url: "/logout",
    method: "post",
  });
}

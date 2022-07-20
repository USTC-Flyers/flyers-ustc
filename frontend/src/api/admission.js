import request from "@/utils/request";

export function admissions_get_all() {
  return request({
    url: "/admissions/",
    method: "get",
  });
}

export function admissions_get_my() {
  return request({
    url: "/admissions/user_detail/",
    method: "get",
  });
}
export function admissions_get_user(user_id) {
  return request({
    url: "/admissions/user_detail/",
    method: "get",
    params: { pk: user_id },
  });
}
export function admissions_query(data) {
  return request({
    url: "/admissions/condition_query/",
    method: "post",
    data,
  });
}

export function university_query(query_string) {
  return request({
    url: "/university/",
    method: "get",
    params: { query: query_string },
  });
}

export function university_get(univ_id) {
  return request({
    url: `/university/${univ_id}/`,
    method: "get",
  });
}

export function programs_get(univ_id) {
  return request({
    url: "/program/",
    method: "get",
    params: { uid: univ_id },
  });
}

export function admissions_create(data) {
  return request({
    url: "/admissions/",
    method: "post",
    data,
  });
}

export function admissions_get(id) {
  return request({
    url: `/admissions/${id}/`,
    method: "get",
  });
}

export function admissions_update(id, data) {
  return request({
    url: `/admissions/${id}/`,
    method: "put",
    data,
  });
}

export function admissions_delete(id) {
  return request({
    url: `/admissions/${id}/`,
    method: "delete",
  });
}

export function admissions_upvote(id) {
  return request({
    url: `/admissions/${id}/action/`,
    method: "patch",
    data: { action: "upvote" },
  });
}

export function admissions_downvote(id) {
  return request({
    url: `/admissions/${id}/action/`,
    method: "patch",
    data: { action: "downvote" },
  });
}
export function admissions_query_page(data, page) {
  return request({
    url: `/admissions/condition_query/?page=${page}`,
    method: "post",
    data,
  });
}

export function admissions_get_all_page(page) {
  return request({
    url: `/admissions/?page=${page}`,
    method: "get",
  });
}

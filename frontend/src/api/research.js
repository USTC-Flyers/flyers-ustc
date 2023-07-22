import request from "@/utils/request";

export function research_get_all() {
  return request({
    url: "/research/",
    method: "get",
  });
}

export function research_get_my() {
  return request({
    url: "/research/user_detail/",
    method: "get",
  });
}
export function research_get_user(user_id) {
  return request({
    url: "/research/user_detail/",
    method: "get",
    params: { pk: user_id },
  });
}
export function research_query(data) {
  return request({
    url: "/research/condition_query/",
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

export function research_create(data) {
  return request({
    url: "/research/",
    method: "post",
    data,
  });
}

export function research_get(id) {
  return request({
    url: `/research/${id}/`,
    method: "get",
  });
}

export function research_update(id, data) {
  return request({
    url: `/research/${id}/`,
    method: "put",
    data,
  });
}

export function research_delete(id) {
  return request({
    url: `/research/${id}/`,
    method: "delete",
  });
}

export function research_upvote(id) {
  return request({
    url: `/research/${id}/action/`,
    method: "patch",
    data: { action: "upvote" },
  });
}

export function research_downvote(id) {
  return request({
    url: `/research/${id}/action/`,
    method: "patch",
    data: { action: "downvote" },
  });
}
export function research_query_page(data, page) {
  return request({
    url: `/research/condition_query/?page=${page}`,
    method: "post",
    data,
  });
}

export function research_get_all_page(page) {
  return request({
    url: `/research/?page=${page}`,
    method: "get",
  });
}

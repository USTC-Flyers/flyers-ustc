import request from "@/utils/request";

export function background_create(data) {
  return request({
    url: "/background/",
    method: "post",
    data,
  });
}

export function createTopic(data) {
  return request({
    url: "/topic/",
    method: "post",
    data,
  });
}

export function getAllTopic(category) {
  return request({
    url: "/topic",
    method: "get",
    params: { category: category },
  });
}

export function getTopic(id) {
  return request({
    url: `/topic/${id}`,
    method: "get",
  });
}

export function updateTopic(id, data) {
  return request({
    url: `/topic/${id}/`,
    method: "patch",
    data,
  });
}

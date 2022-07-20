import request from "@/utils/request";

export function createTopic(data) {
  return request({
    url: "/topic/",
    method: "post",
    data,
  });
}

export function getAllTopic(category) {
  return request({
    url: "/topic/",
    method: "get",
    params: { category: category },
  });
}

export function getTopic(id) {
  return request({
    url: `/topic/${id}/`,
    method: "get",
  });
}

export function deleteTopic(id) {
  return request({
    url: `/topic/${id}/`,
    method: "delete",
  });
}

export function getTopicRevision(id) {
  return request({
    url: `/topic_revision/${id}/`,
    method: "get",
  });
}
export function approveTopic(id) {
  return request({
    url: `/topic_revision/${id}/review/`,
    method: "patch",
    data: { status: 2 },
  });
}
export function rejectTopic(id) {
  return request({
    url: `/topic_revision/${id}/review/`,
    method: "patch",
    data: { status: 1 },
  });
}
export function updateTopic(id, data) {
  return request({
    url: `/topic/`,
    method: "post",
    data: {
      related_topic: id,
      ...data,
    },
  });
}

export function getTopicMeta() {
  return request({
    url: "/topic/get_meta_title/",
    method: "get",
  });
}

export function getTopicCategory() {
  return request({
    url: "/topic/get_category/",
    method: "get",
  });
}

export function upvoteTopic(id) {
  return request({
    url: `/topic/${id}/action/`,
    method: "patch",
    data: { action: "upvote" },
  });
}

export function downvoteTopic(id) {
  return request({
    url: `/topic/${id}/action/`,
    method: "patch",
    data: { action: "downvote" },
  });
}

export function followTopic(id) {
  return request({
    url: `/topic/${id}/action/`,
    method: "patch",
    data: { action: "follow" },
  });
}

export function unfollowTopic(id) {
  return request({
    url: `/topic/${id}/action/`,
    method: "patch",
    data: { action: "unfollow" },
  });
}

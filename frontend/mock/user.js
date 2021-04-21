
const tokens = {
  admin: {
    token: 'admin-token'
  },
  editor: {
    token: 'editor-token'
  },
  test:{
    token: "test-token"
  }
}

const users = {
  // 'admin-token': {
  //   roles: ['admin'],
  //   introduction: 'I am a super administrator',
  //   avatar: 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif',
  //   name: 'Super Admin'
  // },
  // 'editor-token': {
  //   roles: ['editor'],
  //   introduction: 'I am an editor',
  //   avatar: 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif',
  //   name: 'Normal Editor'
  // }
  'JWT test-token': {
    name: 'test'
  }
}

module.exports = [
  // user login
  {
    url: '/api/login',
    type: 'post',
    response: config => {
      const { username } = config.body
      const token = tokens[username]

      // mock error
      if (!token) {
        return {
          code: 60204,
          message: 'Account and password are incorrect.'
        }
      }

      // return {
      //   code: 20000,
      //   data: token
      // }
      return token
    }
  },

  // get user info
  {
    url: '/api/info',
    type: 'get',
    response: config => {
      const { token } = config.query
      console.log(token)
      const info = users[token]

      // mock error
      if (!info) {
        return {
          code: 50008,
          message: 'Login failed, unable to get user details.'
        }
      }

      // return {
      //   code: 20000,
      //   data: info
      // }
      return info
    }
  },

  // // user logout
  // {
  //   url: '/api/user/logout',
  //   type: 'post',
  //   response: _ => {
  //     return {
  //       code: 20000,
  //       data: 'success'
  //     }
  //   }
  // }
]

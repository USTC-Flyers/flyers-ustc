<template>
  <el-table
    :data="notificationList"
    style="width: 100%"
    :row-class-name="tableRowClassName">
    <el-table-column
      prop="created_time"
      label="时间"
      width="180">
    </el-table-column>
    <el-table-column
      prop="message"
      label="通知"
      width="300">
    </el-table-column>
    <el-table-column
      label=""
      width="100">
       <template v-slot:default="table">
        <router-link :to="{ path: `${notificationList[table.row._id].ref_obj_name}`, params: { id: `${notificationList[table.row._id].ref_obj_id}` }}" tag="span">
          <el-button type="text" size="small">
            查看
            <i class="el-icon-edit" />
          </el-button>
        </router-link>
      </template>
    </el-table-column>
    
  </el-table>
</template>

<script>
import {getNotification} from '@/api/user';
export default {
    data() {
        return {
            notificationList: null,
            operationsMap: null,
        }
    },
    created() {
        console.log('created');

        this.operationsMap = {};
        let [UPDATED, UPVOTED, DELETED, APPROVED, REJECTED, REPLIED, MENTIONED, PINNED, UNPINNED, PR, REPORT, OTHER] = [...Array(12).keys()];
        console.log('created');
        this.operationsMap[UPDATED] = '';
        this.operationsMap[OTHER] = '';
        this.operationsMap[PR] = '';
        this.operationsMap[UPVOTED] = 'success-row';
        this.operationsMap[APPROVED] = 'success-row';
        this.operationsMap[REPLIED] = 'success-row';
        this.operationsMap[MENTIONED] = 'success-row';
        this.operationsMap[PINNED] = 'success-row';
        this.operationsMap[UNPINNED] = 'warning-row';
        this.operationsMap[DELETED] = 'warning-row';
        this.operationsMap[REJECTED] = 'warning-row';
        this.operationsMap[REPORT] = 'warning-row';
        console.log('created');
        
        getNotification().then((resp) => {
          console.log(resp);
            let results = resp.results;
            for (let i = 0; i < results.length; i++) {
              results[i]['ref_obj_name'] = this.pathMap(results[i]['ref_obj_name']);
            }
            this.notificationList = resp.results;
        }).catch((err) => {
            console.log(err);
            
        });
    },
    methods: {
        tableRowClassName({row, rowIndex}) {
            console.log(row);
            let operation = this.notificationList[rowIndex];
            return this.operationsMap[operation];
        },
        handleClick(row) {
            console.log(row);
        },
        pathMap(name) {
          if (name === 'TopicRevision')
            return 'topic_revision'
          return name
        }
    },
}
</script>

<style>

</style>
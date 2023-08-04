Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E891CC001DF
	for <audit@archiver.kernel.org>; Fri,  4 Aug 2023 09:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjHDJnf (ORCPT <rfc822;audit@archiver.kernel.org>);
        Fri, 4 Aug 2023 05:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjHDJnd (ORCPT <rfc822;audit@vger.kernel.org>);
        Fri, 4 Aug 2023 05:43:33 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBF130EA
        for <audit@vger.kernel.org>; Fri,  4 Aug 2023 02:43:32 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RHLPX0NsWz4f3pFP
        for <audit@vger.kernel.org>; Fri,  4 Aug 2023 17:43:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.26])
        by APP2 (Coremail) with SMTP id Syh0CgAnCNY_yMxkvWbiPQ--.12730S4;
        Fri, 04 Aug 2023 17:43:29 +0800 (CST)
From:   Xiu Jianfeng <xiujianfeng@huaweicloud.com>
To:     paul@paul-moore.com, eparis@redhat.com
Cc:     audit@vger.kernel.org, xiujianfeng@huawei.com
Subject: [PATCH -next] audit: remove out-of-date comment in auditd_reset()
Date:   Fri,  4 Aug 2023 09:41:55 +0000
Message-Id: <20230804094155.283766-1-xiujianfeng@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAnCNY_yMxkvWbiPQ--.12730S4
X-Coremail-Antispam: 1UD129KBjvdXoW7GryxAryktw4UGFy8Jr1DZFb_yoWfZrc_Wa
        18urWkWr1ftr9Ivw1rAw4fWF1Yqw18ZF1xu34FyFWUWw1DX3s5t3Z7CF1rtr95tayqqr4D
        CF909FWjyw12yjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUboAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s
        0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
        daVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

From: Xiu Jianfeng <xiujianfeng@huawei.com>

Since commit 48d0e023af97 ("audit: fix the RCU locking for the
auditd_connection structure"), auditd_conn is changed to a global
pointor protected by RCU, and doesn't call auditd_set() here, which
makes the comment don't match the code, so remove it.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 kernel/audit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 45b2fb1e45af..0905750779a4 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -640,7 +640,6 @@ static void auditd_reset(const struct auditd_connection *ac)
 	struct sk_buff *skb;
 	struct auditd_connection *ac_old;
 
-	/* if it isn't already broken, break the connection */
 	spin_lock_irqsave(&auditd_conn_lock, flags);
 	ac_old = rcu_dereference_protected(auditd_conn,
 					   lockdep_is_held(&auditd_conn_lock));
-- 
2.34.1


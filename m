Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D41EC77B78
	for <audit@archiver.kernel.org>; Thu,  4 May 2023 02:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjEDCuU (ORCPT <rfc822;audit@archiver.kernel.org>);
        Wed, 3 May 2023 22:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEDCuT (ORCPT <rfc822;audit@vger.kernel.org>);
        Wed, 3 May 2023 22:50:19 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DB7E4E
        for <audit@vger.kernel.org>; Wed,  3 May 2023 19:50:17 -0700 (PDT)
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 3442o4UR070169;
        Thu, 4 May 2023 11:50:04 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Thu, 04 May 2023 11:50:04 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 3442o4vG070166
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 4 May 2023 11:50:04 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <9ae2c1df-1f20-a40b-35ed-1dc76b122a4f@I-love.SAKURA.ne.jp>
Date:   Thu, 4 May 2023 11:50:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Can AUDIT_LIST_RULES causes kthreadd-spam?
Content-Language: en-US
To:     Rinat Gadelshin <rgadelsh@gmail.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     audit@vger.kernel.org, linux-audit@redhat.com
References: <ecd4bf68-3bf1-a1d8-4da5-5fbd28c51a6b@gmail.com>
 <CAHC9VhTXHLS7bsDJ8-dSp4dQSQRcKRLiTMRYJOJVCY11G5D85A@mail.gmail.com>
 <e5713a91-37b0-d32f-a0d2-eb668122c9e4@gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <e5713a91-37b0-d32f-a0d2-eb668122c9e4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On 2023/05/04 7:12, Rinat Gadelshin wrote:
> On 04.05.2023 00:27, Paul Moore wrote:
>> Can you be more specific about the kernel threads you are seeing, are
>> you seeing multiple "kauditd" threads?
>>
>> % ps -fC kauditd
>> UID          PID    PPID  C STIME TTY          TIME CMD
>> root          89       2  0 Apr28 ?        00:00:00 [kauditd]

I don't think so.

kernel audit subsystem uses kthread_run() in order to run short-lived kernel threads.

  $ git grep -nF kthread_run kernel/audit*.c
  kernel/audit.c:1006:    tsk = kthread_run(audit_send_reply_thread, reply, "audit_send_reply");
  kernel/audit.c:1700:    kauditd_task = kthread_run(kauditd_thread, NULL, "kauditd");
  kernel/audit_tree.c:789:        prune_thread = kthread_run(prune_tree_thread, NULL,
  kernel/auditfilter.c:1193:      tsk = kthread_run(audit_send_list_thread, dest, "audit_send_list");

I guess that either or both of audit_send_reply_thread/audit_send_list_thread is launched
for many times.

> Are there any debug options for the kernel that I can set, rebuild the kernel,
> re-run the test and clarify the situation?

Since comm name is not available but you can afford rebuilding kernels,
counting which thread is launched could be the first step. Also, any
characteristic aspects in your usage; e.g. creating many namespaces,
crating many audit rules?

Please try something like below diff:

diff --git a/kernel/audit.c b/kernel/audit.c
index 9bc0b0301198..c28cd4ac0f30 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -911,16 +911,19 @@ int audit_send_list_thread(void *_dest)
 	struct sk_buff *skb;
 	struct sock *sk = audit_get_sk(dest->net);
 
+	pr_info("Started %s\n", __func__);
 	/* wait for parent to finish and send an ACK */
 	audit_ctl_lock();
 	audit_ctl_unlock();
 
-	while ((skb = __skb_dequeue(&dest->q)) != NULL)
+	while ((skb = __skb_dequeue(&dest->q)) != NULL) {
+		pr_info("Calling netlink_unicast\n");
 		netlink_unicast(sk, skb, dest->portid, 0);
+	}
 
 	put_net(dest->net);
 	kfree(dest);
-
+	pr_info("Finished %s\n", __func__);
 	return 0;
 }
 
@@ -963,6 +966,7 @@ static void audit_free_reply(struct audit_reply *reply)
 static int audit_send_reply_thread(void *arg)
 {
 	struct audit_reply *reply = (struct audit_reply *)arg;
+	pr_info("Started %s\n", __func__);
 
 	audit_ctl_lock();
 	audit_ctl_unlock();
@@ -972,6 +976,7 @@ static int audit_send_reply_thread(void *arg)
 	netlink_unicast(audit_get_sk(reply->net), reply->skb, reply->portid, 0);
 	reply->skb = NULL;
 	audit_free_reply(reply);
+	pr_info("Finished %s\n", __func__);
 	return 0;
 }
 



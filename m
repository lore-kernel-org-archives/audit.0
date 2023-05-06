Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755DBC77B7F
	for <audit@archiver.kernel.org>; Sat,  6 May 2023 06:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjEFGum (ORCPT <rfc822;audit@archiver.kernel.org>);
        Sat, 6 May 2023 02:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjEFGuj (ORCPT <rfc822;audit@vger.kernel.org>);
        Sat, 6 May 2023 02:50:39 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826C7A5CB
        for <audit@vger.kernel.org>; Fri,  5 May 2023 23:50:38 -0700 (PDT)
Received: from fsav111.sakura.ne.jp (fsav111.sakura.ne.jp [27.133.134.238])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 3466oROs065204;
        Sat, 6 May 2023 15:50:27 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav111.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp);
 Sat, 06 May 2023 15:50:27 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 3466oRMk065201
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 6 May 2023 15:50:27 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <0e748195-d3ba-88c5-1b1e-5a9c447bea57@I-love.SAKURA.ne.jp>
Date:   Sat, 6 May 2023 15:50:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: Can AUDIT_LIST_RULES causes kthreadd-spam?
Content-Language: en-US
To:     Rinat Gadelshin <rgadelsh@gmail.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     audit@vger.kernel.org, linux-audit@redhat.com
References: <ecd4bf68-3bf1-a1d8-4da5-5fbd28c51a6b@gmail.com>
 <CAHC9VhTXHLS7bsDJ8-dSp4dQSQRcKRLiTMRYJOJVCY11G5D85A@mail.gmail.com>
 <e5713a91-37b0-d32f-a0d2-eb668122c9e4@gmail.com>
 <9ae2c1df-1f20-a40b-35ed-1dc76b122a4f@I-love.SAKURA.ne.jp>
 <CAHC9VhTfxqrWaJrBccDY9LJR+Fggr__zufD-Wd=0VZwN5bBU6g@mail.gmail.com>
 <415a4871-4d84-a31f-5417-e850a98bbffd@I-love.SAKURA.ne.jp>
 <7c4caf66-a0ae-4999-172e-437d6cfc8ff3@gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <7c4caf66-a0ae-4999-172e-437d6cfc8ff3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On 2023/05/06 7:12, Rinat Gadelshin wrote:
> The only one `auditctl -l` request was performed.
> I see the following response in syslog for the request:

Thanks for rules.

I tried "auditctl -l" with these rules, and I got only

  audit: Started audit_send_list_thread
  audit: Calling netlink_unicast (repeated for 32 times)
  audit: Finished audit_send_list_thread

as output; audit_send_reply_thread is not called in my environment.

That is, for some reason (maybe some process is interfering each other)
audit_send_reply_thread is needlessly called in your environment?
In that case, fixing the cause of audit_send_reply_thread being called
could reduce the spam.

Please try to find who is calling audit_send_reply_thread for many times.

diff --git a/kernel/audit.c b/kernel/audit.c
index 9bc0b0301198..bf4fef7da692 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1006,6 +1011,7 @@ static void audit_send_reply(struct sk_buff *request_skb, int seq, int type, int
 	tsk = kthread_run(audit_send_reply_thread, reply, "audit_send_reply");
 	if (IS_ERR(tsk))
 		goto err;
+	dump_stack();
 
 	return;
 



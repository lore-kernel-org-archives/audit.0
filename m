Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCF5EB64DD
	for <audit@archiver.kernel.org>; Tue,  8 Aug 2023 00:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjHHA4s (ORCPT <rfc822;audit@archiver.kernel.org>);
        Mon, 7 Aug 2023 20:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjHHA4r (ORCPT <rfc822;audit@vger.kernel.org>);
        Mon, 7 Aug 2023 20:56:47 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A9AE9
        for <audit@vger.kernel.org>; Mon,  7 Aug 2023 17:56:46 -0700 (PDT)
Received: from dggpeml100024.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKZVZ1bj6zrS8y;
        Tue,  8 Aug 2023 08:55:34 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml100024.china.huawei.com (7.185.36.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 08:56:44 +0800
Message-ID: <9f1981e4-596d-729a-cfa6-778d0798846c@huawei.com>
Date:   Tue, 8 Aug 2023 08:56:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next] audit: remove out-of-date comment in auditd_reset()
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        Xiu Jianfeng <xiujianfeng@huaweicloud.com>
CC:     <eparis@redhat.com>, <audit@vger.kernel.org>
References: <20230804094155.283766-1-xiujianfeng@huaweicloud.com>
 <CAHC9VhRLzd5Qimc-Q3xe8RRXM=6CCFkWbh5=fJObhaZWhPSpcg@mail.gmail.com>
From:   xiujianfeng <xiujianfeng@huawei.com>
In-Reply-To: <CAHC9VhRLzd5Qimc-Q3xe8RRXM=6CCFkWbh5=fJObhaZWhPSpcg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml100024.china.huawei.com (7.185.36.115)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

Hi,

On 2023/8/8 2:20, Paul Moore wrote:
> On Fri, Aug 4, 2023 at 5:43 AM Xiu Jianfeng <xiujianfeng@huaweicloud.com> wrote:
>>
>> From: Xiu Jianfeng <xiujianfeng@huawei.com>
>>
>> Since commit 48d0e023af97 ("audit: fix the RCU locking for the
>> auditd_connection structure"), auditd_conn is changed to a global
>> pointor protected by RCU, and doesn't call auditd_set() here, which
>> makes the comment don't match the code, so remove it.
>>
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>> ---
>>  kernel/audit.c | 1 -
>>  1 file changed, 1 deletion(-)
> 
> The comment is still relevant, look at the
> `rcu_assign_pointer(auditd_conn, NULL)` call in the auditd_reset()
> function immediately before the spinlock is unlocked.

Thanks for your feedback, please ignore this patch.

> 
>> diff --git a/kernel/audit.c b/kernel/audit.c
>> index 45b2fb1e45af..0905750779a4 100644
>> --- a/kernel/audit.c
>> +++ b/kernel/audit.c
>> @@ -640,7 +640,6 @@ static void auditd_reset(const struct auditd_connection *ac)
>>         struct sk_buff *skb;
>>         struct auditd_connection *ac_old;
>>
>> -       /* if it isn't already broken, break the connection */
>>         spin_lock_irqsave(&auditd_conn_lock, flags);
>>         ac_old = rcu_dereference_protected(auditd_conn,
>>                                            lockdep_is_held(&auditd_conn_lock));
>> --
>> 2.34.1
> 

Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09EAC6FD1C
	for <audit@archiver.kernel.org>; Fri, 24 Mar 2023 02:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjCXCcD (ORCPT <rfc822;audit@archiver.kernel.org>);
        Thu, 23 Mar 2023 22:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjCXCcC (ORCPT <rfc822;audit@vger.kernel.org>);
        Thu, 23 Mar 2023 22:32:02 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B7635BC
        for <audit@vger.kernel.org>; Thu, 23 Mar 2023 19:31:44 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PjR2L0L3mzSnhV;
        Fri, 24 Mar 2023 10:27:54 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 10:31:21 +0800
Subject: Re: [PATCH -next] audit: let the caller of audit_get_sk() ensure that
 net is valid
To:     Paul Moore <paul@paul-moore.com>
CC:     <eparis@redhat.com>, <audit@vger.kernel.org>
References: <20230317033733.1450702-1-cuigaosheng1@huawei.com>
 <CAHC9VhS1Q9Ks_TYjxRe=S8L7kOXS5tuhLV59OA=fnAXN3q3fJg@mail.gmail.com>
From:   cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <a885021e-ba9e-7b53-5ae4-384487640b40@huawei.com>
Date:   Fri, 24 Mar 2023 10:31:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhS1Q9Ks_TYjxRe=S8L7kOXS5tuhLV59OA=fnAXN3q3fJg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.176]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

> I'd prefer to keep this check in place, and I think it may be required
> to ensure proper behavior in kauditd_thread()/kauditd_send_queue().

ok，thanks for taking time to review this patch.

On 2023/3/23 23:40, Paul Moore wrote:
> On Thu, Mar 16, 2023 at 11:38 PM Gaosheng Cui <cuigaosheng1@huawei.com> wrote:
>> The caller of audit_get_sk() must ensure that net is valid, otherwise
>> there will be null-prt-defer, for example, in the netlink_unicast().
>>
>> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
>> ---
>>   kernel/audit.c | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/audit.c b/kernel/audit.c
>> index 9bc0b0301198..6a42a3801d01 100644
>> --- a/kernel/audit.c
>> +++ b/kernel/audit.c
>> @@ -285,16 +285,13 @@ static pid_t auditd_pid_vnr(void)
>>    * @net: the destination network namespace
>>    *
>>    * Description:
>> - * Returns the sock pointer if valid, NULL otherwise.  The caller must ensure
>> - * that a reference is held for the network namespace while the sock is in use.
>> + * Returns the sock pointer. The caller must ensure than net is valid and
>> + * a reference is held for the network namespace while the sock is in use.
>>    */
>>   static struct sock *audit_get_sk(const struct net *net)
>>   {
>>          struct audit_net *aunet;
>>
>> -       if (!net)
>> -               return NULL;
> I'd prefer to keep this check in place, and I think it may be required
> to ensure proper behavior in kauditd_thread()/kauditd_send_queue().
>
>>          aunet = net_generic(net, audit_net_id);
>>          return aunet->sk;
>>   }
>> --
>> 2.25.1

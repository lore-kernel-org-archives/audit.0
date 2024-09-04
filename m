Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510B4BA2E
	for <audit@vger.kernel.org>; Wed,  4 Sep 2024 01:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725414334; cv=none; b=fuy1Q1XBrdicI656bMCR/44+67W4oldSXhjbIlzCPxC2hhFzXPoh3UEKdFl+7/EIINDQp4YZGzUFYdXHuarwTf2apQyRUgB8yqxPqXEvFhHIjPMkBBpglQxjzHvE9ubZmX1bjshq5BFcA3ZT9nRXpYMqOJcCHxK7ESRWR52+Kpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725414334; c=relaxed/simple;
	bh=FLh5+2c40wqQnMQ+3XKu/X//IzIG5Wf34r6XVgrKVMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WNvFeAIsWtL4uFR89oA65Q3URFQFqYyLRLtydqOScr+keFIQPtweHHZCfwA6XW8FRuSgS99F0GZPdo40n4JZG7TOThhcbCE/zs/V5HCotZKMyjrrNlWhDkAloJZYA3gbr+pa/5tPeo0CUxMPVz1gPyxPn+74+H8UZUKpW36Xpwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wz50442JLzyQwX;
	Wed,  4 Sep 2024 09:44:52 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 38A591403D2;
	Wed,  4 Sep 2024 09:45:30 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 09:45:30 +0800
Message-ID: <8ffc1d4d-faf6-4a58-aa0c-f4024f6633aa@huawei.com>
Date: Wed, 4 Sep 2024 09:45:29 +0800
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] audit: Make use of str_enabled_disabled() helper
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>, <eparis@redhat.com>
CC: <audit@vger.kernel.org>
References: <20240831095251.4163011-1-lihongbo22@huawei.com>
 <fb52142f466d0c5852293b83bc7d3650@paul-moore.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <fb52142f466d0c5852293b83bc7d3650@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/9/4 4:35, Paul Moore wrote:
> On Aug 31, 2024 Hongbo Li <lihongbo22@huawei.com> wrote:
>>
>> Use str_enabled_disabled() helper instead of open
>> coding the same.
>>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> ---
>>   kernel/audit.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> We're at that point in the development cycle where I don't normally
> accept much other than bug fixes, but this is trivial enough to
> merge.  Merged into audit/dev.
> 

Thank you, I got it!

Thanks,
Hongbo

> --
> paul-moore.com

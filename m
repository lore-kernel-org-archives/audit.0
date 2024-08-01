Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B0213665F;
	Thu,  1 Aug 2024 01:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722475538; cv=none; b=m3aZNBy0O90TQJQVLjOtQjNnUA9HSDlsFxq8HhGVojxVx2Gb7MBLQZq+F8KyBC6h3CwQ9RwQ13rKU+Z5YV5sFJ0ykBYpZlUjYGQkcwyx1Wc5JbOFck/V98okWz0t6cWym2r964mK/o4hQbxpxvY5CHOW7mH0c3WjSKtt5b8uhEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722475538; c=relaxed/simple;
	bh=to+7SQt9WbFxX26DnU30VnCw3qf/eqdeKPr/AaIivF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gTlStDuKHlBIoAk4YV7ZiFKH4NDsXpy+J/hrd9Kq3W42lJXk1yGDxuvF5ZjtbqcYCHzC/Rhuv8Qdy/GV5LEFuShJ0V9gmvf2myJwiLF49mdQ5ohHn0towKWY7y7KblCw6sRdJHge35mZ14tIC7MPNz9aDTJw81RMj0pXDxYpRYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WZB7S17cJz17MyL;
	Thu,  1 Aug 2024 09:23:48 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 916641A0188;
	Thu,  1 Aug 2024 09:25:33 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 Aug 2024 09:25:33 +0800
Message-ID: <765b4384-ab4d-c202-9efd-1138bc42e9e7@huawei.com>
Date: Thu, 1 Aug 2024 09:25:32 +0800
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] audit: Use strscpy instead of memcpy when copying comm
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>
CC: <eparis@redhat.com>, <audit@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240731075225.617792-1-ruanjinjie@huawei.com>
 <CAHC9VhR9MC9GhGZi_1ftycfGyeuCQ=BXgAs+v+9D-nXWg+eu=A@mail.gmail.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <CAHC9VhR9MC9GhGZi_1ftycfGyeuCQ=BXgAs+v+9D-nXWg+eu=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/7/31 23:51, Paul Moore wrote:
> On Wed, Jul 31, 2024 at 3:46 AM Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>>
>> There may be random garbage beyond a string's null terminator, memcpy might
>> use the entire comm array. so avoid that possibility by using strscpy
>> instead of memcpy.
>>
>> Link: https://github.com/KSPP/linux/issues/90
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  kernel/auditsc.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> If you look at audit_log_pid_context() you'll see that we don't record
> the entire task::comm field, we only record up the NUL byte, so any
> garbage present after the end of the string should not make it into
> the audit record.  We use memcpy(), as opposed to any of the string
> based copy functions, as the task::comm field is relatively short and
> having to count the length of the string in addition to copying the
> string is likely more expensive than simply copying the full buffer.

Thank you very much, You're right, sorry I didn't read the code
carefully enough.

> 

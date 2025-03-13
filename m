Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAEE26772A
	for <audit@vger.kernel.org>; Thu, 13 Mar 2025 12:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741868986; cv=none; b=X6LmCQQ3X+bFi0rqL0+nLTFPN8KPNNxSrG2iM/X3RIl7yKCCq/CG1KXM0gtlo5CfXj3m5fUGhM8wKQCjxPdwdhgw9zVo4/bD+C166xJMVR32XCQB+98K6oJyejswf5zw3pykducCXPXty+7D6Sn+P1d292TmlNthXXnjVbAN4XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741868986; c=relaxed/simple;
	bh=1g+NyktzSKK2XkKOy3k13nywcL9Mhib0LiUglpwfgZw=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=A4afzzsHUwLk/Y8NZigZYUM18OabACV/MCkfgZ5D0UdILutk7iygJAWNS+IKfVpZV0Vw5muzy9u2Jxh1cy9kwURRq0SwXxmFRSUH+7pRtYfqaq0J8O3sziyDJuJbpjQCoiF0HSfbfrcWXtCKI3ogYn2KUdKzhKStnot/fcgN0XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CQWub/lC; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CQWub/lC"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-476ab588f32so11616011cf.2
        for <audit@vger.kernel.org>; Thu, 13 Mar 2025 05:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741868982; x=1742473782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Zwf41u2oqw87EX3fkunUasMCQRwAQQeTNbOgyP9FzA=;
        b=CQWub/lC8wNKB1Yhwx5NObbw85YNuo9VstX4QF7oFij3y04I4Ugh+rPvM188+fNxux
         mJwhLF/AAjVpSEo+4QeZCQpxSTqlodQNJHsTrmSvAiQe5Usfrp8q/polQIRVqYyCjMBA
         FrL1OxfapIpq9Bbn7F0kXk7Uwab2MmbFLowUAhdl/VPv+rs+2Bm4a5Hg4G+2f8dmJUUC
         IBQvwMVxy/e1w3SV7cOF3wM6ba+iW9/zOVojPMYumqAvpWsbHvYf4Rh0Yu87z8+nl7PQ
         7LHuuchejJduzP5pjXxYV2vdfHRX4WTFaSL6cdYWvGC3RCAqvRHIzcZQV4Jkxi5NnT6W
         4x6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741868982; x=1742473782;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Zwf41u2oqw87EX3fkunUasMCQRwAQQeTNbOgyP9FzA=;
        b=SW2ZIf+hgE2lS1a/fNsgUDxyIxBpXkYOBRJOH6/Tgyl+qEmrivKt6aVf63pqSmdK3o
         W2SZ7FGLwbmNLx2zhPAgs11/RujaK2btdh0nbwHHFfCIEyj1sn7zkC6Y0Nqdw+E9m7sx
         2roXTXun8ykAp7c7vK7SPQjxQ21zY85bpwJtXi4RGstwCwQGF8T8P/4BA/GE+7ZkZa6a
         yygFuRpz3iyxoKTkDqYwef/izHJA29rDYD7kLdT3+7eaQkt0ZkE0jBYjW0O0KZ0isz0s
         RI8+Jx1nMyO0df1trP2pEu39giT3r21naWnt9Y2w4fnhdQl1HwvrSFgVV/x6fGU65lUI
         ijDw==
X-Forwarded-Encrypted: i=1; AJvYcCV8nf2zhGYEjiZlCf1atI9mzpjLGEhjjI1ZVDZ84E5bBUC7tzhYCR/4eJyfjD4KnmlL6IyENQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVcCLKzo+0mAVa9KD5hr7e+rPGFw6ngwQLpLxvCzjMkV5icU4p
	WB1ZxSut2anySA7jmF/YRQmIbQcZgw78WZQELJ1nJhMZV1geexERpMVpETfrUQrdT8BdpOqOYSo
	=
X-Gm-Gg: ASbGnctnrRCxJfj/J5zznaXXDrS7X9ab9uQaADDpD9dPrGWQ2YAcfOTaVsFDU+ahkyc
	06w8iwPX0CZQHHlvg5rqNRHxT+Pl5gUIDhv405kmJvY19c+Egwobs47aL5glao2kWESX0eDPiac
	fm/xZBzVAxqmIoEzxzWjWAaiM/aQXWGxbVCx8XLGZPxlyZ+zZBYq4M9srjRPMoMTCkn5Mlw9toG
	EpLcDlHTlEH109VHQZ+g1Q4bHtxP5tDyffKTUALy3Ea//an/t4bJs5NxvdPLqIQBNVSNlOMPwuy
	OWaI12X82BUbsYNameYjqOYVe+sVO0vSUYJqE72AqVsKxpxHnKRe/SHDzV9TwJjx6IAczsG03nt
	h9QNOUDl5ap/vx7M6cXQ=
X-Google-Smtp-Source: AGHT+IFnv2N7W3t0ayHxjjtCyn9mUUoe/Hxh3K5QKhmpW8fJk7aFYPPODamWfDzX3U1KP5rz9GLzbQ==
X-Received: by 2002:ad4:4eed:0:b0:6e8:9957:e705 with SMTP id 6a1803df08f44-6e9006752e0mr464948326d6.34.1741868982415;
        Thu, 13 Mar 2025 05:29:42 -0700 (PDT)
Received: from [192.168.7.16] (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade24eabesm8979316d6.67.2025.03.13.05.29.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 05:29:42 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, <eparis@redhat.com>, <linux-security-module@vger.kernel.org>, <audit@vger.kernel.org>
CC: <jmorris@namei.org>, <serge@hallyn.com>, <keescook@chromium.org>, <john.johansen@canonical.com>, <penguin-kernel@i-love.sakura.ne.jp>, <stephen.smalley.work@gmail.com>, <linux-kernel@vger.kernel.org>, <selinux@vger.kernel.org>
Date: Thu, 13 Mar 2025 08:29:36 -0400
Message-ID: <1958f7b4780.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <5ea749e38c39e783741bdd0491a1338d@paul-moore.com>
References: <20250307183701.16970-5-casey@schaufler-ca.com>
 <5ea749e38c39e783741bdd0491a1338d@paul-moore.com>
User-Agent: AquaMail/1.54.1 (build: 105401536)
Subject: Re: [PATCH v2 4/6] Audit: Add record for multiple task security contexts
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit


On March 12, 2025 7:51:36 PM Paul Moore <paul@paul-moore.com> wrote:
> On Mar  7, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:

...

>
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index 540894695c4b..79a9bf4a7cdd 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -168,6 +168,7 @@ struct lsm_prop {
>>
>> extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
>> extern u32 lsm_active_cnt;
>> +extern u32 lsm_subjctx_cnt;
>
> I'm not loving this.  More below, but I'd really like to hide some of
> this detail inside a LSM API/hook if possible.

Thinking more about this I think we can't go with a LSM_MAX_PROPS, or 
similar determined at build time since we have the ability to toggle LSMs 
at boot.  Need to think on this some more, but the answer is going to have 
to be a variable and not a #define.

The LSM init work I'm doing right now directly impacts this, and I'm in the 
final stages now. Let me see what looks reasonable and I'll get back to you.

--
paul-moore.com
>



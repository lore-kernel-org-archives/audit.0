Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA59F6F2F2
	for <audit@vger.kernel.org>; Sun,  5 Jan 2025 01:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736040236; cv=none; b=hGRp0z90vWPrWkGdf7Ksg0MWO5ZRlEFkwN+KwbqJ6avqaF3msyXIvDZAVBMsENiDfg9ust+nndg3s/PH/lkKPBluaR5Q3+k/JILAOPh38dZ2izdtNf64JkGEi1TEIvhYREr1oGsWZqneCQXsGhKaaAL9lqT+/aPIHxDm3XOLJ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736040236; c=relaxed/simple;
	bh=/btT7n0d2ZHfop1mstfeCbgn8fQGxmS9KNdzrV2Bi94=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=qYtXp76QLREx4HWMb7rOQVmhGs7Qj49l6UbnRdbWhZoi23BJ/DwNlDJvCni46BAh2HN1IZoaMMEwamHfl+tMBnfBZ2kQEsUScOK1A1DPNPruzAvvF2LhKwHIho72eIrRvKHOmKBF56bPYCElXgXAJob8208EKeAuZ9umVxCt3Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GvgYGqlH; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GvgYGqlH"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b700c13edaso703272285a.3
        for <audit@vger.kernel.org>; Sat, 04 Jan 2025 17:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736040233; x=1736645033; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oodCSrqLJ6/wV1EWtq/vcEze69LUP+43yNurMHOkC/o=;
        b=GvgYGqlH/rvxgULg/8rP5+4dRnkP5HEko5Kvlge17oaSgsoM9ZIkbbmLm/ITYrWLxg
         XqHfyErLJLeTdiYda9xZltV3lQbWrdUsaWaPZah8pCs7p460/74XPQ+/ySSSuJoqFJAL
         OZWbl7ak0sYn8idvoGRwCR+E23qEAToCP8oWaZ1H3mZ5J7e/PKOE6HVHcwGPQk9dzpRD
         gv/VXK7KGwVFzTpghm4wti1yGrUNYnA0KeuflF02bM2ItXSY6yuVmpHW19UFsC6W24Xy
         uDEj3kk0q8qvn0komBt0wSl4juyBz7mSPvUPheKwv3RfjWuMfClAZFtodgesLh7Vuqb3
         am7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736040233; x=1736645033;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oodCSrqLJ6/wV1EWtq/vcEze69LUP+43yNurMHOkC/o=;
        b=R+C77THouL2SCsTfSEU2aTXTUKHfGvOxvSR5hMlevOUgLZUT74vnhwkwpdNKLUOL3G
         C2HC7C0ZOaY+tIJxLDhWN4KUHYywAZRKI6vdkdul5W4RsrmYHiSQER+ZG6XXOJpCrsed
         qVyHYvwm+6XpNNLnnN+uLs4UbUM6QOu4sqyA57su+AT5I4aDyP+UwXAN00W8nI6C9q5g
         FVOPTu2B3h2+8ISjizN75Ox2NwyvQsIN9cD6MEYPlEoTc1VkpSiRuSzArKW/W20oSsUS
         hL508x9WJH0sayRGAa5qFve9L+B/g/y84pjZzIcFZgouXtkS5IxogX+qDoo6NVpI3k15
         NdaA==
X-Forwarded-Encrypted: i=1; AJvYcCXY2zMjmkiuyLTmm6QWkCzWIB56ix8Wcz5GN8dy52ppFW6P1HN1bJ8szGwGutfGDzdwzJPxXg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Rg6aC/Be3/ikozz/6SYIftNqRvHWvl0QiK7hQBUEbTmdQN91
	LwHuvrJePCVHochu7Z0/rRIixuaf/MjVOVf+vgUkYOFxpBWrMaFgWja+2vx7Lw==
X-Gm-Gg: ASbGnct5IzP37AwFSo9b3YPxZz2joYtEs2/W6d7WzWw4lQpo5lZZG7f5ZmJFb8bFWbW
	OVRkcel3BRdlFYi6FI36I3XK8i6VWw4XPKmZwNQqtJ6TqIL8rxW17SJtEpIsBSke+PjpAAtEmiS
	9RSRK0FFhNRTTCpuHtzASO2InPr6z8vMy+gAyNf3lfLQqh35srMdVXPqXFZ5Mhrok9w2Bu/YGtt
	Zrg+Vkw4iM1HEOtSf2UCL9zi1NGDVoGdpbeWA5lReaZ9yXnlII=
X-Google-Smtp-Source: AGHT+IGH4CFrIPXTbsb1KbkdD0mCjpfzWpvEGfeBYbIb7PKQ7U7KdTUnGjDro4NTziohWutc9MBYew==
X-Received: by 2002:a05:620a:3915:b0:7b6:dd82:ac9c with SMTP id af79cd13be357-7b9ba6ef8a0mr9033023885a.12.1736040233637;
        Sat, 04 Jan 2025 17:23:53 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac47a354sm1390202485a.70.2025.01.04.17.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 17:23:53 -0800 (PST)
Date: Sat, 04 Jan 2025 20:23:52 -0500
Message-ID: <0055bef6843289ac8dc728a68326513d@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250104_1133/pstg-lib:20250104_1133/pstg-pwork:20250104_1133
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Eric Paris <eparis@redhat.com>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Ben Scarlato <akhna@google.com>, Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, Francis Laniel <flaniel@linux.microsoft.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, Tahera Fahimi <fahimitahera@gmail.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 17/23] landlock: Log TCP bind and connect denials
References: <20241122143353.59367-18-mic@digikod.net>
In-Reply-To: <20241122143353.59367-18-mic@digikod.net>

On Nov 22, 2024 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> 
> Add audit support to socket_bind and socket_connect hooks.
> 
> Audit event sample:
> 
>   type=LL_DENY [...]: domain=195ba459b blockers=net_connect_tcp daddr=127.0.0.1 dest=80

The destination address and port is already captured in the SOCKADDR
record for bind() and connect(), please don't duplicate it here.

> Cc: Günther Noack <gnoack@google.com>
> Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20241122143353.59367-18-mic@digikod.net
> ---
> Changes since v2:
> - Remove potentially superfluous IPv6 saddr log, spotted by Francis
>   Laniel.
> - Cosmetic improvements.
> ---
>  security/landlock/audit.c | 12 +++++++++
>  security/landlock/audit.h |  1 +
>  security/landlock/net.c   | 51 ++++++++++++++++++++++++++++++++++++---
>  3 files changed, 60 insertions(+), 4 deletions(-)

--
paul-moore.com

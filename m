Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793331208;
	b=CjGv324H07prSsAi1EAkbrOANe1hnIpxnkr8JYLspieIo422mtmZwOoTqcjXZTOAMfLa
	 +FF6VDhLRVh5HEfrgbBOaRifxF7ehSMswpRA1EX5uG703XFc8yV7u+X6j6c5kr8Lj8tDW
	 X8zBH4dUPYyJC6ZdMbIhht1j9P4S86/dpYAopT2lVVUOKHcUDFIBFaIxsvg0NkrcIdDXw
	 VN9lZhitPTwQyXTPCrSoui/PGngbJJYqdtfcqbr1oQE6LVvydGNR3RL1lGbYrr4cyTVhw
	 RzG9iyZvwgxFDoMlwxnDd50d4sH0fkk0dqKsGSQh/yqMxXel6fUjB7iA+Qrz2S38zzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793331208;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6rss23bXzihYLvh5XkbaLwnETqaIZS+Fw5w7OvzrICE=;
	b=cggsJ3l+IlGA6q4NlLQHlJ2BwMCl/s0SANZg+Bm0VCY2/bB8rpkfawDfo7UwgVwCkhKJ
	 7nwAfA84U7P1w7Yu7SntsMxB5cIa7oXxZUed/MkifVomGXFoIhUBXil9AKZvX+1q3YxgK
	 xy/dS3YUf9xnZxT13pPxlGn6DXd1WAC+DktF2agJZqvyYDFdWr4lfL5Vgfp+Wl3rbSzSS
	 fxi6Aq+BWeBOpelK84+E4W9lc5NU01UFQGHzEeEHlhuW+KBlpz6tn6zEV0KS1SdZXRMhA
	 Un9yuzPgdYTr38fUcZ6Gjt9mXX3Rm4JKo5OoYCTz15nANlO4MPGde4RPlIpFe4/86xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iQkj2yaq;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68B7606A31D
	for <audit@vger.kernel.org>; Fri, 30 Oct 2026 03:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A68B7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iQkj2yaq
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a06c60065fso109852b3a.1
        for <audit@vger.kernel.org>; Thu, 29 Oct 2026 20:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793331207; x=1793936007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6rss23bXzihYLvh5XkbaLwnETqaIZS+Fw5w7OvzrICE=;
        b=iQkj2yaqagmPOtWMHT45u4esFyGIUD7mtvdDsjB7v2RP15ecu6KRKGVGrwF/zlOAVR
         pKvg2RWxdTOAfSpVDvgNrWZfI0pIzR6lfZbpAd+vTzp9sJ4xCUjf3Oxps4poHBIms4l6
         OeZJvlsIhckLi/XCSoQ1XO2LThlzLRGh/kg/O71hHPS9F5htFVTvNb6l9Hf2eDgLlhhw
         jQM0WzxZet1na56DYjAqupJYnDUQVgzwJAz/zxt+XdKdW6+1+qxmx/SNnze/sPTUnIXA
         hSItjX8j4R6gzuuufTb/x1d3eSmm5r6t/pPv3jI0pKLghpfP6jbuSxIHdS7vMdzojcu+
         XL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793331207; x=1793936007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6rss23bXzihYLvh5XkbaLwnETqaIZS+Fw5w7OvzrICE=;
        b=xxvTiAM6eCkbvIBdOdar7jh84onQ0JYECojw2+U1gFr9s0ioi9udGEivX9dMQLJu44
         ejDxvxQ/lvyOf0ISkztXyABlYpC8SEOuhmFnUK6N1GfrCFSVau2gPeRT4WR6FkinvV/K
         b6kgLozTh7K3B0qgqUJR+Befb1ovmZSzWkKlnBK6/4+BksmWnzlynKJZZYFpojft7x0q
         xIbBhIYKvYtW0v/btUBCuERFHcuNq6jtIWR2KKkdnwykegzO0YQGdJqtuMXZJGfoPFkR
         WMqKBpWjRdggaWr/KreSKvOESjP5c0HsBxDdnsa/5DvprUnFhtOcltln3rdAe/QORE00
         xf5w==
X-Forwarded-Encrypted: i=1; AKwUvBxXByk9UtnsPl4lRNFy5h5o1+3VwEaHW1yo1Y7wu9Ui5FkodM3mfjWzLwlS3sXRrCd7jxYNzA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIcPQtaXBm6YflkH7Qf4bX55jo6Xh5w3DteSiXNRZB/QoczkvgL
	vgqn7KoqFVCGhBUPlk1F4dV/kf4e3LPjgvZgMijpGZwkCtJaWmV5VyFaz14WMW45+e8=
X-Gm-Gg: AYBFou3PfKMQrrZR+TZ5tNCelD/1MtlwgBRzWkFlD1KvOLDZLfDV3AizvVhJnxy/ztq
	ZYhSSVBiAuoIajFjRg3vIc5p0JtwbYAj2CaKbfLmI3SyAyX0q7eSWU6c7dRYwQT3EeKMAVgkB2F
	5uZ9rKdvY4tT2prsno0M51pTspNXonTbR/S64N0Mv838b+nSLgLBI0NtMd/vkA3mrx5TrDTSNeR
	xBsQ8H0K31lCAkHyocoEtHqEBTxzUeFmDu1TdKO67FepFFHgyxFjusaziRAH70/ZZEYiitMngOS
	2Smqyeete2VqLpE81toRwmBiGyYjFWb2qPdptRXBEcgyaOFxmE8VpKS/3eWCuLjr4WRF5Hx96of
	fBbWRo0xyOdGfRCzcBqlCPIZfV03rpyBDDZ6aF4RUPInDHtbwu925+PNPNUHXoUYcUhEOBWS/Ut
	PKLXEQckA0kh0OQsDJc0co71E4EpC/6QcWLiSGbB24V1wV7OciiYpPG8YKrSWFk6Wxp/g0Hxchm
	Cf0XIEPAuocg1UfFpPv3u0EjByYbFiquLu+vWPRRVKUQSXNooyODASOREWmYWIYa28WE6Qarib6
	dF9W8E83TUi4Pi6tCStlJjgJmw==
X-Received: by 2002:a05:6a00:2d0a:b0:89e:92e:4211 with SMTP id d2e1a72fcca58-8a9bcff6a3dmr946518b3a.16.1793331206869;
        Thu, 29 Oct 2026 20:33:26 -0700 (PDT)
Received: from kdev.. ([187.15.154.74])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a9ecf5665asm196545b3a.7.2026.10.29.20.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 20:33:26 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@redhat.com>,
	Bradley Morgan <brads@mainlining.org>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bbnpreetsingh@gmail.com
Subject: Re: [PATCH v2] audit: annotate the lockless read of the audit control lock owner
Date: Fri, 30 Oct 2026 03:33:20 +0000
Message-ID: <20261030033320.7-1-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261008034403.7-1-bbnpreetsingh@gmail.com>
References: <20261002011712.7-1-bbnpreetsingh@gmail.com> <20261008034403.7-1-bbnpreetsingh@gmail.com>
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Post: <mailto:audit@vger.kernel.org>
List-Help: <mailto:audit+help@vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
List-Owner: <mailto:audit+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paul,

Gentle ping on this v2. It has been three weeks, Bradley gave it a
Reviewed-by and Tested-by, and I don't see it in audit/dev or audit/next
yet. If you want something else changed, tell me and I will respin.

Thanks,
Babanpreet

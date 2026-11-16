Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794866754;
	b=udJnA2gft2w5nVQNuTMRAt8cF6Gp5LozVlTUeHfpAUiCMru1fdktxuS47VZtcoSY5iQB
	 +iHo+44ohukiCDk9tspKNPWsBu5M2MiAiYJFHdTxZCxDGD7tH7jYoT+eBpu8R5p6rZWP7
	 KXNqY3uVz1fkAIzsoCz0M34+8cjE3mCua2mzrDuB8Z84q39oTFO+nVzhupCI3fvfFl+pv
	 A6qRHUrVhAW4Rzy3+2u2raChDsc2DcOw8fCDXJrY+ycwhFNA0eqwqhESNxfCx7P/ucppg
	 x+xDILOXq/oN27YQPVkHDS0EhCp3R/EhULeurRg0sf58qfx3eNxyHfr0HuLpwbjKEaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866754;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:From:To:Subject:References:In-Reply-To;
	bh=wJHow9k8AKGQ7tpQXOPTURa3uMuatWd/jNocJOYQInc=;
	b=EAxAJalym8qxSpOQkuIh235UO/oJnopDc7TI+Y/CHWcN5VJpBjIj+OU6S8hDeWOAyDfr
	 ZML6i13xC3UjPOKIpMlH3s73m/jFxrNd8ht93+EF9T5Y0FnHdZYF7X1oxSIgLFKFOXX2n
	 P0P/YC3dtJJJEpUjFKQdZdu1yU6etxq6EkgxF5Bxc+nlwq1KlRrbuNOsWWe3mGQD5DEVZ
	 LbImgIRcuR6P+UbkI+cw8RCjukFlvfCWoVZ0zI8P9fwlCOjs47zR1Ee9gLQpPpq+c/023
	 VJhwjKDniGPxz1govqRmhNCsU7xIDhpfc6/k529fh7OzKWskLJOUUIAwNOV1YglfIsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=OHdA0sxE;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26384606A31C
	for <audit@vger.kernel.org>; Mon, 16 Nov 2026 22:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26384606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=OHdA0sxE
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-949589c1495so328418985a.3
        for <audit@vger.kernel.org>; Mon, 16 Nov 2026 14:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794866753; x=1795471553; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wJHow9k8AKGQ7tpQXOPTURa3uMuatWd/jNocJOYQInc=;
        b=OHdA0sxEHy1igYBjCEmTdiiPTwtOvhUHeZ0m3uacRy51FNpec3nXAzzByLtlJMBI6f
         JszxaVC3ZfxTA+yeVJ85ARCjwmtIZYyNaOEO85jQ0JbamQjJSSp0d0N2+ZRRS7Yfmsm3
         306LspTmmswFM8FA12kbnmBI0S8XbqKCQsg0yIN56L9MDeoNX9eR5K5vfQila33LflYw
         YEstXTm56/d/nHigYO9k3PZcvJMXengyIk8kw0E+g2krDSKh53+BdPjElQXvyatoJcXy
         VOEdnkX54V+sINGEc7mUF54X/MeC1Xi6e4DDTlSyUrFwTuzt55QKh3xbN1aBS8W7hjHO
         GwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794866753; x=1795471553;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wJHow9k8AKGQ7tpQXOPTURa3uMuatWd/jNocJOYQInc=;
        b=feFx0cBqY5ov5gIJRWM+Y56Q+kUXiZN/nITI5bRb0VBAPUF1o0mpdGRKr0dlqWBTg8
         7z3s5wYVlVl/8xxrmQl8Pjs66kLe6crEWHxhmgK6AJDBU4Gdq8hibnYmryO4b/TdOxv1
         UFeRghpMs7qtPmw9PiQRmMJTQzk2xPGVf1bqh9+l1tHIhZBLFLMPz3hf4H29d83EU4dM
         ooNKAcTBWLqFNW+8uJeCYImPVD8RQOW5wGySImcxX+JIEK5Nk/FQTa6yp+g5cbPhfBP6
         QmHMzBKDVOERdjOtYIIaO8yfPSs9/dt+wOyf5u3xuIVtTBhT/wx3TZHmE66YfOh5KsT3
         sgtQ==
X-Forwarded-Encrypted: i=1; AL+hErHgwPwltldKTYEG5txNW+U/Yfaleyq/zT+Tcux5E0iYTj8ekyRaOunOFsXLb/ZpaslAqPJa2Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z8oOaeRaFHy4QoQ7qIc3IpT6a8PwYYCoac2ZxqouHudDHrckndt
	WBBO0AZIzQV4EAnOyraREm7BHUqqy57yyEulBtXaIRUl1ZA9TXLAFOPMdrE5BfNyNQ==
X-Gm-Gg: AYBFou1444tVYW1HcoF7Rz1BQNmEchkH185S4GEN+GDbXBJiavOgjm5rmnENCff1Ta3
	UE4gYvz/bgTGMsbhNW/hBxBWubHd8gldYe4BtTvEFrY3kAwLnXn+FYoppRBmsh7OAQBoLoVH0wT
	JUTzgvD1j33rFSNhiz8H04yLK6j+ip+gPlVmqZxLCkjd9Em6tphH/gnaS+lQ9SiiQistij7nrLT
	/qE0lMYnOyoC3+CeYwqAPQlhcHKXO7M6Pofnu0gxkGqD6MncQhu4SxD3oPx8qK+WTfiDLkOr3vd
	O9a1oSuuJfx+eNdfpYMcd0cYyQBNa1jAcNQp3H5lq11b79Jm6Fxn47ngAVH9t7bQg4j1cjU/gHo
	vGr6ie8ZErvjio3jCXdCxgnNmSkmkveVs7WSXkh4Hb9FnFlP7u5Cx35IbmNbPGz6w7GKxYIXRHU
	5kfsYLoZSJFXynXI7giszsm3kfQOcNhZgPNowmw7iURdHsKb5Oj3IO/x5fUoOnHctdOWY64Dxr4
	PqfVfb6cm5X0aRNCcwS1w0Su+gqvXuVC+Pz+oPkqIWC6/XxNXE4WoW0ZhSK6UlWDR9+xZLpNeIn
	5Ur/tjALjleqtYWt04DiMc+3xukUM+sSDAbbOKIHh16G4F540tGW47niPEVi6cSn1ax41bFIqFf
	xihpXo6WfPtNZya7jpXTrF47nCuV+1w==
X-Received: by 2002:a05:620a:1998:b0:93e:c12c:9b73 with SMTP id af79cd13be357-9494bd16084mr1944492285a.78.1794866753142;
        Mon, 16 Nov 2026 14:05:53 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9497a4f1bccsm387623585a.36.2026.11.16.14.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:05:51 -0800 (PST)
Date: Mon, 16 Nov 2026 17:05:50 -0500
Message-ID: <67f550346acfdbcd1679156103ab3a40@paul-moore.com>
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Post: <mailto:audit@vger.kernel.org>
List-Help: <mailto:audit+help@vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
List-Owner: <mailto:audit+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20261116_1350/pstg-lib:20261116_1227/pstg-pwork:20261116_1350
From: Paul Moore <paul@paul-moore.com>
To: sashiko-bot@kernel.org, audit@vger.kernel.org
Subject: Re: [PATCH v2 1/3] audit: compact name entries and context fields
References: <20261106150342.670199-1-cgoettsche@seltendoof.de>
In-Reply-To: <20261106150342.670199-1-cgoettsche@seltendoof.de>

On Nov  6, 2026 sashiko-bot@kernel.org wrote:
> 
> Group the inode metadata and the small scalar fields of audit_names to
> remove padding, while keeping the pathname next to its length and the
> file capability revision next to the file capabilities. Store the
> per-name file capability revision in s16: it must represent both the
> eight-bit on-disk revision and the -1 AUDIT_INODE_NOEVAL sentinel. Keep
> the existing formatter and its unknown-capability output unchanged.
> 
> Move name_count ahead of the embedded name slots to remove two alignment
> holes, and place personality before the task credential scalars.
> Preserve the first int dummy member required by audit_dummy_context(),
> all five embedded name slots, and the existing allocation and reference
> lifetimes.
> 
> On x86_64 with SELinux this reduces audit_context from 928 to 880 bytes,
> leaving room for descriptor paths while staying below 1 KiB. On the tested
> arm64 configuration without property-bearing LSMs it falls to 872 bytes.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v2:
> - keep name next to name_len and fcap_ver next to fcap
> - move name_count below the names_list comment
> ---
>  kernel/audit.h | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)

This is better, thanks.  Merged into audit/dev.

--
paul-moore.com

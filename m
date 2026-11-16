Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794866756;
	b=BQR1abVXB02VAwZKRTiHdMdDOitWHw9dkmjPhJ1BWI8z2F0BGW0NwZo4NcHfNmgwts/7
	 bvSDY5HQAwYMk4+BIF1/Q3+khlcGHwe99d1tOkxYEJi0OLQd6ad37A5YzOqDYzNs2aQdi
	 5y5zBXm8TC3PgpIkaMHJ2r79IsFpW3hU+tigVDH/iFeN0gYap4bkCBQEQLAJZDt+T0seB
	 rDJNp4Nc88UKXJImQ4uz3OITolPgVemvAYXyCKAEbCqEzRl54Te2mdzOOSUOTYIdRrxf2
	 2Nhz8aC+p8ciDzypjKcDROfc25XobfxWoLraJB/mBi6/yXceU2j4ubeegBOoJPnjWZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:From:To:Subject:References:In-Reply-To;
	bh=aCkr6RSM+td79mzveJSYcar0nv+C6+sU7wxzDmOe4RI=;
	b=KYLVO27n9dQZsaFhScFT3Dkou3TSUUH6dh1vIIlEMmiygc9mxZXew/20eWWosSd0P1KW
	 DTJQcWTVcA7KtqGB4udKdpp3FzLkjHsCcISC4z4i2KNVQThUooJBO1ynQL7ws8T/zecTV
	 8j1RiDFIrYBc8JLWBSmSjm320aFI4yoQI2QigPm8IHadfajzcpF2BHwtKhy56ogRkc8D+
	 /wIpPBYPUINYJGKCVZm5b39X7UgKZMYsm7MsVmB2bcuKMdIiSbsfjAfc3hSo0gyp/X4EW
	 szVjadMIsvoMUv5SeOc0m0/8qEh3Kl9NtIQKdg54Rq0xEN75mL3wx462Hv32cyt9FHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=afXwUazd;
	arc=none smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B719606A31C
	for <audit@vger.kernel.org>; Mon, 16 Nov 2026 22:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B719606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=afXwUazd
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5361e313e63so56684511cf.3
        for <audit@vger.kernel.org>; Mon, 16 Nov 2026 14:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794866755; x=1795471555; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aCkr6RSM+td79mzveJSYcar0nv+C6+sU7wxzDmOe4RI=;
        b=afXwUazdCHUNRCNrPMExxJA1Waxo1hjwf94b/ZBGFG5lcu1hLfbV/O1SQ0iGPSCVvP
         ofLwlCJhy4Sg4fCeGAF4nUP3BGiiXosjSAzqM8scTb1IQAWInl4zJiKDiz7YnlzqW3cz
         5Wjhk4iYtUrveoCOz+CRwqxXtVakfbBJfdLxO/YS8ZGlngkQy+kAy7CRauj/9xibvb9V
         gxbtRuk5k4cNg+p947wYqgdEefzpm3dsCOh6L1mo+Oe4BoLVVIIXT2C8PxWEzvFeIeYv
         T4bYxLkb64PCHG9fGZwvVVLSv/O3qfHYqzmkfzSFzgHoyAOOQQaUhELBLmROPXdPO3vQ
         K9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794866755; x=1795471555;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aCkr6RSM+td79mzveJSYcar0nv+C6+sU7wxzDmOe4RI=;
        b=c8yHbZe72oQi20enFwpOMmDUa0fxo3jUOATlCtVXEfCa8PYRQWRoM+nSTkS3uOoEey
         QH52bk4mKAdOuiJd4r1hANHBKkt6Gj+9DHTeVL67AZ2lSzdfETHP9GUg9nl0jgZe5/L/
         BKD2FhodwiXDb7+LI5H2aIcKSVb4ymc4plMzgKYaFyKYTEwVuFGnTJnnpHmBfTDN61zf
         gTOYNzSqzLDT3fjhksHT3NK9CI7gQmNWzFpcQs/Gm6x8cO7R49FcPxeQ5dHCDd8OVDvB
         rIMehpwTC5/qgohZo0lJc7WlZi9AUg5sd+mah20JpKQd3H557bXor3BroqWhw9ODhRlB
         SA2g==
X-Forwarded-Encrypted: i=1; AL+hErFN7YBDPR3lB4FtuZr7oenkEXCleghnXKt/3P+0y58Rqs3tmOmePcz8tOkXBQbp/vjyMfwQCw==@vger.kernel.org
X-Gm-Message-State: APuU4Z957IiMIRS7yQdRKGgmvJohOATaNVEZsAvqyBc+0z0BR0piCCyQ
	SHeWu4RgB5/bdtFQjJYu4iGHNAmA6Kpo43KB1NJcrWH/o3JG5Cq3pmwKKv8J9IFZV/E9J+W7dqb
	9oxE=
X-Gm-Gg: AYBFou1R+qQhK82BOKrxTehejl7zG4rnezGmT+7zoOqV5izMtDWTpjPsIn3wKsvQW1H
	05L7e43ZK7WatGyS0L1/KTRRGzIT10HuPULU4/uFcBvKacdtiLDCBGcHNFO0M8XuLo0i5LTbBRu
	XK5w8fliESIdI/7JFfn2JPvy75it0/X3q04GE/QuYZjhNRBHDCl6niv98//sGwl0OGrLlXpmmDM
	JzvRAnOB2NAJDmqYALOPuAjhdDe8uHgfXiZrxUxvbN5+ayCoxO758/7dsYvoiQ2pwvgrxaFLP8p
	E1zQ7RseRK3OmN9Op+ObFTocgOWxcTxk2SeTCY3eP7I/emCr5U8x9Ku2zUaQlmLSI3M42/mlYdl
	i5s8MOI3DbUoTdIqLWIFqgSlFd361gyunCv7UGecPbVmrvLcR31FpAhG8U4YHFEqh14w6ZC9Db7
	OYZ3KymFHnXL9JQnwHwBPWec/qQxsKWYoJ1G3uhh8BsyZZiDgrC9PadBum3VemFMqXTeGSKzjL7
	y8NnJ1V92N0L2MqC44zpa5Um+R+4MAQYd79Bq/Uafhmdr+p36dZ+Zy4Wq7lhnFCUUZEMey7orv3
	Nogq+2L/K4xUgSDYwX1Nq8WlpciMzuSkyTl7qMagN5sj5vLYJRUCLJrA3kus7bym2KyNujE5uPW
	8IgMMXay9GW4qVYhUfazwvHGFGCt/rOyEXNiACJifaomWxv4fO+Y=
X-Received: by 2002:a05:622a:2299:b0:536:9743:791d with SMTP id d75a77b69052e-55ac84725e9mr176413831cf.44.1794866755329;
        Mon, 16 Nov 2026 14:05:55 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad0a2006csm90957601cf.10.2026.11.16.14.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:05:53 -0800 (PST)
Date: Mon, 16 Nov 2026 17:05:53 -0500
Message-ID: <a8d349514bcf1c0a856736ccf0e94d6f@paul-moore.com>
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
Subject: Re: [PATCH v2 2/3] audit: return the collected entry from  __audit_inode()
References: <20261106150342.670199-2-cgoettsche@seltendoof.de>
In-Reply-To: <20261106150342.670199-2-cgoettsche@seltendoof.de>

On Nov  6, 2026 sashiko-bot@kernel.org wrote:
> 
> Return the selected audit_names entry, or NULL when collection is
> skipped or fails, so audit_file() can attach descriptor-specific
> information reliably. The existing audit_inode() and
> audit_inode_parent_hidden() wrappers ignore the result, and collection
> behavior is unchanged.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v2: return the entry from __audit_inode() instead of adding a private
>     helper
> ---
>  include/linux/audit.h |  6 ++++--
>  kernel/auditsc.c      | 14 +++++++++-----
>  2 files changed, 13 insertions(+), 7 deletions(-)

Merged into audit/dev, thanks.

--
paul-moore.com

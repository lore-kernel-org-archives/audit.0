Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5752313BC0C
	for <audit@vger.kernel.org>; Mon,  6 Oct 2025 03:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759720910; cv=none; b=lqhbw+h++fKUhOQUQJ98FUWAbZYO0/xhPmp+anGXme+bvLZvXgbun4e+5rLb6YbORHD+/UX3VRXWAyz7Ql4eL4Qdj4sDwCVFygADRpaQRfVeDmEQ24XicvIX6FhqqKL4zCwHsX1LMeZSdheA5vDZexdAKnXth0e4x4tvoDchO1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759720910; c=relaxed/simple;
	bh=Fs0DmBhUH9tA1PYMetiifcOi7IhfSdT65e1scj6FNlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ibb30IZgAIuNpIzPU2ojGihhuJfzwOw19b7Eziw8/nIGvwWMG7ps3n4heJbfS0IiMWPcyrhqrAkZTWmE9mb6jKZ722z8BsV31xmEhNx2ZQuzDpnzAHCHtxQb/HR579c7+tjaI+pMP4hqjB/4DQkpptDCEwltSsfRtkNd+z6AGGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RznsyZHz; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RznsyZHz"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3324523dfb2so3813892a91.0
        for <audit@vger.kernel.org>; Sun, 05 Oct 2025 20:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1759720908; x=1760325708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNe1BtFwZCWEPhXLGHatFUWM31AoQgF+OLUDVfKFkjA=;
        b=RznsyZHzQP8mMp2XLdgvQqz2NMbnpeQuCxpV98JZvJD6kEUjNsXOi1BxHR/BM+fgOh
         XZRO0dzdjN4nJddjVAD/DWuQDZvHvX+BpE9jhmJ83aAKBNZOLEURdPUDnBSWC8LF/rKN
         e8XgOnUca1xtbngngI4ccnFSR/TXSLNKVaGxwHnNaLBAp7gw9NSkNuaTMnTehmWmxFrf
         ziClhqHHql5wwoZ+YNq27H++YGe9zAwDa9wQnTe+eeleusd4k0a43k+5ThnGrZpZ56Nf
         /Bw1KN6nHVuKgY81IIebj10tl/E9rkskFtLFyKWu7qdpuYOUmpplyH06IGQ4Cd41HXnd
         jaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759720908; x=1760325708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNe1BtFwZCWEPhXLGHatFUWM31AoQgF+OLUDVfKFkjA=;
        b=P728ADfR4Ys0opWjiRQdcGyofCKS2AAju2/8nEAmQP/j9SldMR97S85TFhp7+0yttO
         UKgvq886B6aS6iUkdxFK32HClbIwciwhX9toXPAxBjzl+5QFF4BXi1DknLERdtNiD/dP
         c9UPPVL5RGwI1AQVIjq+GFwp3ryVm19Iz0FCIIC3JpVoHUOanphQgOttUsoAeYdm//dc
         J/IJSyXepe51WeyW6UcoVXLXPLCU4LS3zeCmcsXWSNAboe2tAiLzN0Q/KykzJ9iS7YDu
         h5yVCn4TVPsQnvc2sMHOIED9kTWQI2TaJ2kDOamZHT3oUvDVi9bzdFVPgW/VuZmAxR6c
         ZFHA==
X-Gm-Message-State: AOJu0Yxh+TQYQDWA5rcl1n0A69JsLYMGNHffqnqiStXSMI3yO/ZRWb0q
	j19HtIQnNunFd9k3XSASQDvPEgUwbo6J+DMkTKbn7DOwjSjssbezSc6SVTHXDsqi0URRYI/b1mu
	ClDfs4cSGiGyecvFwvzGMoj6cMBsIzCfH7GZFL6VvO7BC+JquXzg8Xg==
X-Gm-Gg: ASbGncvAFeCVdWkcRgXOrp8MY3/I0YVVdpVmcse6UGsNAkKyXcqTWxMbwXS+CMk2heY
	tm+Ihhw8P9RIXivVxXVnZ1vGY0e9ZdanX+SZ9z4ttKBnhYa0N3a+cPqkqR05qloQgeSJ8hCCZiF
	lV4G3yZO1vyk09P53yIt37epDTg4VKEzitwtiznlDN3UkM19OTk/Rye65o2UcfJV9Pc1yaYG4XT
	0BROrLGfTvhaGxxR09T8qgmVhlcI1YwYGK9ZS0Ang==
X-Google-Smtp-Source: AGHT+IGFq0axzUgjuW/bqeqCCkDDkLDZV1sW0PXrbMNlNKuyMmrGb+MlIyPOuH79npU+uAnuItP+H5DlxaL26jPjukE=
X-Received: by 2002:a17:90b:4f42:b0:32a:34d8:33d3 with SMTP id
 98e67ed59e1d1-339c265ebcbmr14099372a91.0.1759720908573; Sun, 05 Oct 2025
 20:21:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904165919.3362000-1-rrobaina@redhat.com> <CAABTaaB7SxWZUH+VxyOwZWBi6uPERg-qkMosFA=MTst5Rbc6kw@mail.gmail.com>
In-Reply-To: <CAABTaaB7SxWZUH+VxyOwZWBi6uPERg-qkMosFA=MTst5Rbc6kw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 5 Oct 2025 23:21:37 -0400
X-Gm-Features: AS18NWDmHEs_E1xJvOPFbgu_1W3XkerYQHRZHlJgzZHHJrj04sEOcidcx32QCgo
Message-ID: <CAHC9VhSi68-i8om4VYbxRsrK7xpVL-NJy89e01qsa5WTT-hQFw@mail.gmail.com>
Subject: Re: [PATCH v1] audit: merge loops in __audit_inode_child()
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, eparis@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 11:50=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.co=
m> wrote:
>
> Hi Paul,
>
> I=E2=80=99m curious if you have any thoughts on this one.
> Please disregard this email if it=E2=80=99s already in your to-do list. I=
t=E2=80=99s
> not my intention to rush you in any way.

Hi Ricardo,

Your patch was posted right before v6.17-rc5, and with only
approximately a week before the general feature cutoff for the v6.18
merge window, I didn't have a chance to properly review it before the
cutoff.  Rest assured, it is in the review queue, and with a little
bit of luck I should be able to start working through that this week.

As a FYI, the doc below describes some of the basic process for the
audit tree which may be helpful.  If you lose the link, it is linked
off the audit section in MAINTAINERS.

https://github.com/linux-audit/audit-kernel/blob/main/README.md

--=20
paul-moore.com

Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F0EFBF6
	for <audit@vger.kernel.org>; Wed, 12 Mar 2025 20:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741810611; cv=none; b=ZPgCjx0cppUut+aTYJUucN96OP/HOjkz3IJJc/BU8McJvL/LXvqxdXjSI4gpqQ0PLtm5tb8DjjcZaF5Km9RYQPHyAT+1lleLNHsMCvCizSYwTzQdzCePGVYSDe8c4Owiy8Luan/NynUN8QH5wdDJJ883wSoZGD4gXeEmWKbByNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741810611; c=relaxed/simple;
	bh=+xKFX1pp3mEipSSCK8l7b4EKmFag5w8aJf2eklRJ4QI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=beBZ9FxrpOYqTYhP3aIQ/lqJhzrXnqqYvOoNvVR3ma7r6hNMJCCqMiaF3TBd8RiL8opzCLEH3Uy9rlHqOHUeSFl62SALgfvrO84zK8kAEygFUoYeeb6t4dhVdApixgDiPLrO+9nhpAUqbSt+7JgCpuv5mA96/QZPhzYYsfp2aDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VUpyb42c; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VUpyb42c"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6fee50bfea5so2531487b3.1
        for <audit@vger.kernel.org>; Wed, 12 Mar 2025 13:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741810609; x=1742415409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlAiZHSczHL4dPmU0Svxpoh1IeIWVxip/9BPH0/DEs0=;
        b=VUpyb42cv3jxSVh+FkHK+b+yOFpB/jqpxfFd14SrBoYhm5f+xVRBH4/Xpe8d1280Eq
         oZxXvveLVME24iB4B5Nj4CPM/HZtACPaLh513/PXENvN2f7jSyzNUO7PdLtOMjArHaPT
         k/h3xUOuIQyhYUgavBJRZfCBskeBxdTCWDFwBvqqxcC4gQ2zDu/qlaYICzS8e+Jk8doc
         1x8b6gtJUym1+3RNra3noEgZ+D1gF2YUkLRo5CCyEf+RU8UVigfnukJzwaR2j4ris5kE
         9ulqZThheCnHuatp9ll/+LLUcUfoao8uZTK43itHSONNE/ULhikD6kkaJARA8kX+jPKl
         4mkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741810609; x=1742415409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NlAiZHSczHL4dPmU0Svxpoh1IeIWVxip/9BPH0/DEs0=;
        b=BAPXf7XmE14scNJRfpoXNgiGlp1In+dAo0JogV3VsvVw+ggw/8FrOWbTAPiRi/zanD
         kL2gPecm7XEWy+g6s/1pl4/H+xTFWXO1yn9cQ+h7aKVcl0V2s3kM2dEhj54HYSC7It9J
         YHqPKLQkCpGJTTFHlFCsr48zxx9o7l6p5xFlRqUFzjTOZRgIdYB43F3lx4dK1G+NjAmi
         VcxkvHoEH+9pCH+3CClGFL2BOUlCH4LZ/7fU81Rwfn74IbbIkUQy6qwScZH+nAjUaWal
         TvQgETjBIwIgax95xg7nuuPbkG+sDlFUuJ6mSoacCI7SjKWx4oFz7RTtYBnRru5SdRMi
         6vpA==
X-Forwarded-Encrypted: i=1; AJvYcCUuVKenmEIcvFIdiwUCsO4Fl7EPIg36EpdV1nZyKxHpjdU4OFoPBst4F2GG4ovlcFcSc+LccQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxiSb/VrykHaT4kTJypxVsUd0A/RzGyemPnRVvBWjpJBRcqTliE
	zPKSZlnxZbGlxVqSGRQKmbTFqRZbMXYVUCytaDmUNM1ibxzse4jeHTXsEu8lvSQ1m2onVJqM9eG
	7NoexhHeauD7dgmDTWMTTVpRlvo49uFCpis3u
X-Gm-Gg: ASbGncu/xAT1M4sdj1vt10PfblJqIXe8ORxScz24idOCCQbEHTHBVpRXxvq86gLgrCn
	nJtMhTrUmO/qZfK4uXgHZlD9L6I4/L5wJ74QsWVi+h5oQ7gNvO5m0e170vW1vYNH/fsi5THIU2d
	R/AJHP/hamdhzyYoafVsHChxt8kw==
X-Google-Smtp-Source: AGHT+IGsMfpU4NDQUU7HmINQA7wNmAYjX+dxqWkgxOHEnX0Fo1BZ419T/c+57j2erW8jJdPXACroUyNNCW7XYAAoqbM=
X-Received: by 2002:a05:690c:6088:b0:6f5:2793:2897 with SMTP id
 00721157ae682-6febf37b72bmr342709407b3.30.1741810608700; Wed, 12 Mar 2025
 13:16:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312200216.104986-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250312200216.104986-1-andriy.shevchenko@linux.intel.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 12 Mar 2025 16:16:36 -0400
X-Gm-Features: AQ5f1JqM7dTfNxqvjM7Bbx6USu9RTu4JsG1NDCgTEFRgJ8zuzc8E0i2b76FB-ys
Message-ID: <CAHC9VhRHZL+QTsfK2Sg5+rw7RSxUoaF=YTwGW9Oia5xnvqAL1w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] audit: Mark audit_log_vformat() with __printf() attribute
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 4:02=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> audit_log_vformat() is using printf() type of format, and compiler
> is not happy about this:
>
> kernel/audit.c:1978:9: error: function =E2=80=98audit_log_vformat=E2=80=
=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 format attribute =
[-Werror=3Dsuggest-attribute=3Dformat]
> kernel/audit.c:1987:17: error: function =E2=80=98audit_log_vformat=E2=80=
=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 format attribute =
[-Werror=3Dsuggest-attribute=3Dformat]
>
> Fix the compilation errors by adding __printf() attribute.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  kernel/audit.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

It would be good to list the compiler version/flags that triggers this
error in the patch description as I've compiled the audit code quite a
bit and haven't seen these errors :)

> diff --git a/kernel/audit.c b/kernel/audit.c
> index 5f5bf85bcc90..f365e1bbeac6 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1956,8 +1956,8 @@ static inline int audit_expand(struct audit_buffer =
*ab, int extra)
>   * will be called a second time.  Currently, we assume that a printk
>   * can't format message larger than 1024 bytes, so we don't either.
>   */
> -static void audit_log_vformat(struct audit_buffer *ab, const char *fmt,
> -                             va_list args)
> +static __printf(2, 0)
> +void audit_log_vformat(struct audit_buffer *ab, const char *fmt, va_list=
 args)
>  {
>         int len, avail;
>         struct sk_buff *skb;
> --
> 2.47.2

--=20
paul-moore.com

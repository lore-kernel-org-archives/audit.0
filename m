Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED2E4302E8
	for <audit@vger.kernel.org>; Mon, 27 Jul 2026 18:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785175345; cv=none; b=rj8EUdD3PyodWFS+DMh6nvrXdRFzseyMrQ77ees44k78NUGY3Opgqf+RdNoias1Akq8Dj/i25Qq/xzZB/Rz+WG/kg0479jAMx2OCPrWCiq2DkwhtNtooa/z5PmUSm1uDWpm1mrYNFdv9Ws54GdYK8rosohDw6iOtD6LrodVpjdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785175345; c=relaxed/simple;
	bh=0bAYpeAjbkPiuYa1dtg9Dt/Tn+2Uenlk7+0PGNmwXP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IfrV6t+XK1sFbeYYElCAZlxzinxTeBe/T4pHbMdNPsShcUsr4qD6Zcq8UKS4Mr982peKtGkSFLD4gxu+AwB0gp9ugFOL/T7blKmuDCyyjcuXQ4zXBTsqEd3CbO8rL9l6l2V3XQqA0FULcQgNLyJn0zjYkux3x8R7re3/ObCgc+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XY7gpGy1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XY7gpGy1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785175342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XRAOVdaM1RUnbbEZotu3m1z/byAlv3NRncWbmC7bEhI=;
	b=XY7gpGy1qU0J4/M5g2Ff8giJOtb8P/IjpgBy+7os34YGHGX8cT+aS7OCIjGem7MXiP2xcl
	DAPVFy5li2ADc5ohfTv36Lf2RyS4kjtNZfKlYgBVex4UUWeMqqdv33Wcjtu+XwsKHj/q6S
	nucviN4TW6Aqrgb+3waZArwbqk/Rp2M=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-IUhFzUJWMheCB6n36x8FqQ-1; Mon, 27 Jul 2026 14:02:20 -0400
X-MC-Unique: IUhFzUJWMheCB6n36x8FqQ-1
X-Mimecast-MFC-AGG-ID: IUhFzUJWMheCB6n36x8FqQ_1785175340
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c15fc5a1b7eso219036066b.1
        for <audit@vger.kernel.org>; Mon, 27 Jul 2026 11:02:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785175339; x=1785780139;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XRAOVdaM1RUnbbEZotu3m1z/byAlv3NRncWbmC7bEhI=;
        b=UeMd7bkupNQOZEPVmBC52v3GZviO9lAkaTm4+7/Hd0xHRArNToCKMwvTFzL8BE/kEu
         7KCBR/+xm86mL0HALHvRn6Wa1z/yzHmy0kUJwH4YV937WIZhYiKQzOsCXE/4CQowjNkF
         GD6w5JR4cRVL2hgkE7DOfNTNTVaFk53cF5pw0gkkeutvyv+WdY1fcppUeHcP6ubbau1t
         637KkcA0kqyWGjJKsNSvQijeQzvq7rqw/EgsCP/UovChX9viPhlTVVU6kl/oThLZ0qX0
         k9STT7dhr9BwNKQYpgjus4FlDKWDd77TzjcjxpcsTKEKv1hvLMoNWj+cSWx/6W7k+6N2
         RklQ==
X-Gm-Message-State: AOJu0YxOApCdq/Iwn+hgrS7uiXITql1r5TczuoMompTFsrxmxJnEoaZd
	eMpv37BGNlLClaRxVFekqYgSE5LnrwXoI191f659J5UmQXIVdD/JHqmiB99WgXHRNCEKU7b9bA+
	29+p2VoYB5LJ+/+s1olzgYzCg6PSSd3X4pc/EPnVoWNH2K06eaa+F2Jj6gJw/TQWfYM3aXqQzLn
	OjXYl/I6rmgq7m//jyWZp3uv2ibam9FaHTrsA1Cr47YQ==
X-Gm-Gg: AR+sD13ggEU/Vtyybu7s8IfXvWVgsOMQ9/Pse2/76ZGw/rkJsM3izmQDVPz8mZo99bp
	0YBBDFeQFfiF4+KPvYGkHYsb/agzLhYerheRBASHQ/IqvIhMY2hYd3FSFBQIgg0oYbXfRpOhOjB
	d0t3hr5LNkTTAJudZekhuwFcoXvI1yrLgM/N7ZRISCk1LbNnZDR9Kt3GPqZZN4R4SQZMKj8kl+H
	yCZ4lpr+U5Il7RmTIvhQMQrb+wicnrXQT8utZjyvDx5Hxx7MHmMf0/je03OdgRl2mOHlwFgYt8d
	HW0=
X-Received: by 2002:a17:906:730a:b0:c1c:2c54:9889 with SMTP id a640c23a62f3a-c1f1ed0101fmr368919566b.15.1785175339621;
        Mon, 27 Jul 2026 11:02:19 -0700 (PDT)
X-Received: by 2002:a17:906:730a:b0:c1c:2c54:9889 with SMTP id
 a640c23a62f3a-c1f1ed0101fmr368918466b.15.1785175339261; Mon, 27 Jul 2026
 11:02:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724195626.327253-7-paul@paul-moore.com> <20260724195626.327253-11-paul@paul-moore.com>
In-Reply-To: <20260724195626.327253-11-paul@paul-moore.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Mon, 27 Jul 2026 15:02:07 -0300
X-Gm-Features: AUfX_mzB_YK7kglLTirX0YJTQwzkrbhgrPGCXIqWN43HBoDNcattiom8i6fqkaI
Message-ID: <CAABTaaCuNORqv49_ZDcbq8x3LAjb7beuQHEmUjVzGU8AL+y0mw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] audit: add a missing function definition when !CONFIG_AUDIT
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: J5Rfs-i2SgHoJ931UTxQmRC8rN5MdNdzJpBNU9XQOio_1785175340
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 4:57=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> The audit_string_contains_control() function does not have a dummy
> function definition in the !CONFIG_AUDIT case.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  include/linux/audit.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index d327113c913d..ac8f5f77d442 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -237,6 +237,10 @@ void audit_log_format(struct audit_buffer *ab, const=
 char *fmt, ...)
>  { }
>  static inline void audit_log_end(struct audit_buffer *ab)
>  { }
> +static inline bool audit_string_contains_control(const char *string, int=
 len);
> +{
> +       return false;
> +}

Hi Paul,

I noticed a stray semicolon here. Otherwise, it looks good.

Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>

>  static inline void audit_log_n_hex(struct audit_buffer *ab,
>                                    const unsigned char *buf, int len)
>  { }
> --
> 2.55.0
>
>

-Ricardo


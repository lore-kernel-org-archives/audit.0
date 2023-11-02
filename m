Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC017E
	for <audit@vger.kernel.org>; Thu,  2 Nov 2023 00:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="f2Gq/r1V"
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFCB109
	for <audit@vger.kernel.org>; Wed,  1 Nov 2023 17:24:58 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a82f176860so5128647b3.1
        for <audit@vger.kernel.org>; Wed, 01 Nov 2023 17:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698884697; x=1699489497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9WlSD4Ca/HFV738P9h5O+3ftbNBpFens5cZHujKc/A=;
        b=f2Gq/r1Vf/WxJKmoDLnGAd+cN1eQresn1IMNqVfk2MZn+X7azbCRW9WlbUvUidZ2Fc
         1UzCGelqcQlZVleeYx70zFjoiDezbezQ0QVpwICYuWVaFw7iw1v0rtEAo01YpnoV4fk/
         pp+dP2Bx8zaQVsiLaHwBWsRQqKQPKQmulIsepQrcefZ/uQsnWMaRWH0IUv6Swdiq586E
         AWAr+4LMTaaItDtvMOTHVN3QmV4l+pCDpgKosnnr0iKTZFktUE/i0qF9XX4hrT51UISm
         hAbQml4qAvComXNFqFRPRbQ/XXsRrxeuLofYB59cRT93roR8/kFEueUggvMU/iPrxiZy
         +lEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698884697; x=1699489497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9WlSD4Ca/HFV738P9h5O+3ftbNBpFens5cZHujKc/A=;
        b=qQXhV4kUPnPnZ5CqKriYwzYZehLp1jlQZ+k7OXVuNUgwGpVZUkbs7yzde+v03V47zf
         PqE/tQR6YayyelsAXBqaP1sFQlf8RONiZXSWGQFd/2vwOmBCM42svWcvleglphgSjZOh
         w4nsGUA9fs7t3sYcVcXZe1+JSmIkFFcWKPGvEA3fTXILIbXEezpcrj9Z6qbB+EPI5JmA
         lYScfE76XaOXRWrFfbvOdQaaeLbO5QYYpLB0pzUKc+pqSizjXkUazvNKlyr1cKG3Rn+C
         2/9SDiwGeVWoYzhym8bW1gxgJBKg9UQqPRraFhYknOAqAz5uiiAElKcnwouOmFSE8TOH
         S18w==
X-Gm-Message-State: AOJu0YwSafo0Hdx3SxjhtRm2Yk5doQhGofUzK5ycRxGX9akqp1oU11NO
	4mtGrylC2Hat9wY8ee+XQBYVQ71X2qC/SwUtd1Jd
X-Google-Smtp-Source: AGHT+IFmoPhc/fYK0Zr9Ce+OjB/aRiFYDtBQUF7E5FL1N/ZBx92E3kTL8fyE/meNgmLLkrWa0naNqUMLi/7wtb6NOu8=
X-Received: by 2002:a25:ac07:0:b0:d9a:fd15:82a3 with SMTP id
 w7-20020a25ac07000000b00d9afd1582a3mr16641506ybi.24.1698884697487; Wed, 01
 Nov 2023 17:24:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhQBV1mcFUmXQs1-VKpAVdaAQ3EiGk-G3ybxfcBkoKGwcw@mail.gmail.com>
 <20231018092351.195715-1-chris.riches@nutanix.com> <5d398909-ab9c-4837-a71c-7bbf5a8df013@nutanix.com>
In-Reply-To: <5d398909-ab9c-4837-a71c-7bbf5a8df013@nutanix.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 1 Nov 2023 20:24:46 -0400
Message-ID: <CAHC9VhQO0ThV5EAGPiJ74ydyUHGeGp_0Gzfn7aLQKunO_rF9yQ@mail.gmail.com>
Subject: Re: [PATCH v2] audit: Send netlink ACK before setting connection in auditd_set
To: Chris Riches <chris.riches@nutanix.com>
Cc: audit@vger.kernel.org, Eric Paris <eparis@redhat.com>, jonathan.davies@nutanix.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 1, 2023 at 5:59=E2=80=AFAM Chris Riches <chris.riches@nutanix.c=
om> wrote:
>
> Hi Paul,
>
> Is there any update on the review of the v2 patch?

Hi Chris,

I apologize for the delay, this is in my review queue, there is simply
a lot going on at the moment and I haven't been able to make as much
progress as I would like.

--=20
paul-moore.com

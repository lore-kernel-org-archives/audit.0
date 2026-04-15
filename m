Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DCD318B9C
	for <audit@vger.kernel.org>; Wed, 15 Apr 2026 15:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776266534; cv=pass; b=Nf6u8ez+OYgJZ6Mlj3he2NnjR7gCowY/zSTZvtxp5glqM5ZFp1pC/0fhlVGlRHADdauuiccU1mnkV0mYOWgMMJPRd/7tiQyOmKBUgUUW5Ib2sEuM/rNZmt1xIy4QlXJsqruXC/5D26phFUMevM5Vztmz/sYWT0In6kp+OUN5X7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776266534; c=relaxed/simple;
	bh=8aDBoYAH42BIAcbyyDh4WwAfg+/Qio584QqbIfuM5ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qpfdpmqOcOYINdUgJ4NqT04wB3HXsr5cqFi0q7M/2iO7hiDZ2YIxZJawkz37+iOTcjFtvMTW/u2PVZqnKXmet5vATWIWcTDse5EJzXUuYl5k7aUACxxmzcYyWp/YKTuIpu3iutk9szRVIohppkpjjI/D/AdPVKlmOEb/ZLnFwwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=f9CLET3g; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="f9CLET3g"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-671c5eb7fb0so2888959a12.3
        for <audit@vger.kernel.org>; Wed, 15 Apr 2026 08:22:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776266531; cv=none;
        d=google.com; s=arc-20240605;
        b=KL5aKqAqNltj0JjlF1bfJBU1Po/9q5fDzKlKIbtf0cngwyoIPZcLc6WNPlLQDgLa5e
         EiLdfptsmtfBddzHyt4w5ipuaUGvfdV8Yp91v2KKAfivRbFuAr2apFZ/n/4SxCht45Vj
         RV+sLvYMVMeYKFATgB+eDeU3Od+F8uQNXHpEeuePnz42+bFZknGsU1GAzUY+0SRa27tf
         +129TSQUFg++BJ8O3y6RtRf2QigfLKYyJYyfQZ+OmGhWBqfbMMdt1MGjY4+zTLC/WC0+
         cIXoKhPzkVLPLE2cV+/YxrWigFkCrGZ8rdr7O/Cilf7s99ebqyoNFx5MDRUNYW6yxxLT
         a1ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=drIUTElkxzV26yN/xpd8LbcC+ezO+yQ40iDvw1Giv6w=;
        fh=cR1rO8v4h+48qBJVR6HibPQosUZwG4fZVraTx4EcR4Q=;
        b=fSVOhtN5m8f29+H6ue8HVUlAaHUMN8GKWeuUi0vJQ5AbU2Wh8TK2CL0+bqAmmQAgnY
         9eZLtfu0q9u3361Wflxiu7pXkAeCCSOQOWUIrEIcgYPz8n3AZakhBbt+dpBEgGnUxrF4
         +/W7jv04zzJe6neCbv47MfnQx2c/efuDRyhbc8aazvcpBDFlzxVcTXPkeZWb3VFJGRO+
         1IUPpPlqKhH7k/cwY3f4flhJEUDEQ7guz5iBX3tjLZNMw/6NMtHC4/OHNMFWBua4wnkp
         umw3KFN4/qcQzVkU5+SNiKNt+msl97z4Y9ZNfXTpQOhs0JAB80mb2LA2DiLVLV62ZiPv
         U9SA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776266531; x=1776871331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drIUTElkxzV26yN/xpd8LbcC+ezO+yQ40iDvw1Giv6w=;
        b=f9CLET3gk7GXSqjxMev9vqlen31jhV44TTD33T3VvTT5Qz+hr4Nffc75MOkILtuGY9
         i8/aP86wsM7PcaHf2dyw616g/VI3ieLn+U//dXJi4/1/Gh1ZCCpKQ8ssXvfnMfcKIkT7
         94fW+qYwJ2J+rYgl0oFMLfrx5P/UDFAb/uGgiQa0EEP8zrHk3K/FvaJOqUOy1MDXyncA
         OLhwEAlsxtA+RMDqs3Ra780Zopz9mn+19zSV3AgASL7qsD0lQ/sLB18W4Wxa3ddDJEFb
         DlFDlcOO6mylYN3BjIhjGN4jHsKrbHJpJqQwAuwtOqUx1ZTVp9J8crqkc1xXQDsPmy85
         6iRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776266531; x=1776871331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=drIUTElkxzV26yN/xpd8LbcC+ezO+yQ40iDvw1Giv6w=;
        b=rx2rGwD3NbuiO0KdYUx9lyXAeOLaIneirnRQqfKxYtPcWHgD+VFz5vlwts9AgE6XSj
         DXZpfEccYhQIZuIieU7XPtcK8A2jXkLYwMoSfO9qkPJ6q6h8DPxPIZSVazRg74oL8yDV
         XRbW/6CbmmAoxhC43/oPSOHKZC4gsIt0HC1uu4G/JBBZ1ei7aLICsYajDYg/xtg6gE8O
         F/Gw9rW0m8pGs7YiaF+pAxDLGrHxx5H0iYJIm+POdW24MDLaBFSyWwLQKmS9pBH95nx7
         z+mudfPTDHAg5CaPTG/pOSpi7l+XQQgOFrSj0mOwnGMRX9/n8e9NQB7+p1Rdlbj6g/06
         0VNg==
X-Forwarded-Encrypted: i=1; AFNElJ/b0ycKx3D8r2Y9En7L0Py0eLygQd2LwTBBDxVStuVJgVktir8rL1X7caRyNnPW0Sfg4v/N7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5M0ZhboVq5FpbpjP3P5aV2KAgDi58cq7mG3VVZ2is0jh4gFTb
	Za962Lh6l4y7xlX3PcLDdsci9ANY9C9sZF9p/4teYjGaBHU6aATpBltQVqT+KVcNG25OjC7w9HY
	0ZN3vFjwau4Yq4cMXSjGCjPQtMFS6G1PB/RBGH6ks
X-Gm-Gg: AeBDiesdLef6KxZksnFr7PE7u4JHIccQq1UdOLS5Gm8AQHDgHZgC+MigqhOk533u/if
	lCX4NBSfUj5KPJDmITLZbDGBMnu73gl/2dcMZekcGjjDghooX+haCqdWfmGHLwkTGg2za09Z9Q+
	sLtNufeMd/B010hDaECpmWkSpEMSraE+cw4PgZ87iEuJ+HLfBej5SsCDIv9+9co2BfnYyHxMVuV
	WKYfOB1pPRsH0R6H/PC3T0dDP93MEChWndUe55zZcgYv6RAx2PQMGQVwjq+65sPEYGmg6bVjnkl
	5z0UfHcDiBqm+C/xGA==
X-Received: by 2002:a05:6402:42ce:b0:66e:44c:dd3f with SMTP id
 4fb4d7f45d1cf-670786a3249mr10991924a12.2.1776266530823; Wed, 15 Apr 2026
 08:22:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323150700.614139-1-rrobaina@redhat.com> <CAHC9VhQTGfuOYev_UNzwSqUoYX-y+RYyMZgWWG2eGzM62eVm9A@mail.gmail.com>
 <2213475.9o76ZdvQCi@x2> <CAHC9VhSVhN8YW_p4NOS4ptRDjimP9sg5bcg3dH24sDoaTefUUw@mail.gmail.com>
In-Reply-To: <CAHC9VhSVhN8YW_p4NOS4ptRDjimP9sg5bcg3dH24sDoaTefUUw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 15 Apr 2026 11:21:52 -0400
X-Gm-Features: AQROBzCCxun8_y0sHjqjjAZ6z6cN_otVubOFu6pXs7_Zk3mCAZehZiAgWdNYYbA
Message-ID: <CAHC9VhTN+vjkSSjtfFegC9cEAcGAonYY9sNk_84_nJwLay1wwg@mail.gmail.com>
Subject: Re: [PATCH] audit: add backlog high water mark metric
To: Steve Grubb <sgrubb@redhat.com>
Cc: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eparis@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 11:19=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
> On Tue, Apr 14, 2026 at 11:45=E2=80=AFPM Steve Grubb <sgrubb@redhat.com> =
wrote:
> > On Friday, April 10, 2026 5:34:08=E2=80=AFPM Eastern Daylight Time Paul=
 Moore wrote:
> > > On Mon, Mar 23, 2026 at 11:07=E2=80=AFAM Ricardo Robaina <rrobaina@re=
dhat.com>
> > wrote:
> >
>
> ...
>
> > ... compliance-driven systems that must use a finite backlog limit for =
memory safety but cannot tolerate dropped events ...
>
> You must pick one of those two requirements, or at the very least
> prioritize them; it is simply impossible to both limit the backlog
> queue and require zero dropped events.

To be perfectly honest, it's also impossible to require zero dropped
events.  Even in the most extreme configurations where the admin
decides to panic the system, that only happens once the system reaches
the point where it is dropping events.  We try *really* hard to not
drop events, but it is always going to be a possibility.


--=20
paul-moore.com

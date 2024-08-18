Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1FC17BBE
	for <audit@vger.kernel.org>; Sun, 18 Aug 2024 17:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724001783; cv=none; b=neSAaK0K5skXLptatzi1QGuIlqhW7KPVTAenGb+ptlRwLAQiYR5QN9vMoHTRoLaWYl/WZT52Ao8Ftc7O6aj8jVtyfPM3dfCCY7id9Hlt2rmvFIr/JgDKa/W6P2QIkdBkap4yQ36uHND88K4G1nWadzzf3yemu1mp8F+MtmGZpy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724001783; c=relaxed/simple;
	bh=PRdiw6GJWM/P370VLjhMZ0dhU6tZKbF78aSZqYEGp5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ScvQ3azayV4ZOb0Qswf4xBImqRVprFcSzYXKdqbnFfcWFYua7zUbBxq3nvipzGoi9sO05Pju9mxNklDIdi2CokLjyq+H1sxT2Y7zNbOtCmzfcmy+mqeOegega4GmbEmtokPxtKADaiRIDkKJO4ssTarXI9HHQr3Blzd/fSjNoUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=f3X054ET; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="f3X054ET"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-69df49d92b8so33627237b3.3
        for <audit@vger.kernel.org>; Sun, 18 Aug 2024 10:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724001779; x=1724606579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rea1kNp4EkbAOzAU8f/a10Vwm+fxF1V1CIr9tWa1sDQ=;
        b=f3X054ETV7yigtr0M5N3HUiRAAE+GS1VunwBvvTJL3GlmEqi97mnC9yoJnXb7Rojen
         PMwtRmBw52jh/OPas2uIFSpi2wmLB60XDgnSq8lbzpzd3ICq5DpP7Zps52Y1owwUeylv
         A5+MGFnRO/ZsKqkhEyfafUIVWSz7k1wC5HvuIbCjR1KzFOAkvmzuJDl1EqS4Wyg6+VF7
         ao2VZPZQPP3er9vJC4duFXTTopdGJVPTFNX30xslqJI1WzdKebGIOt0pzdsWhDYUzsXy
         hexKTjrJF7q1AJ3GLKTo3qtNNH/BGPqrpgO+QVMzR1XLbjHk843zxBth2qF4DACVkGUD
         2aVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724001779; x=1724606579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rea1kNp4EkbAOzAU8f/a10Vwm+fxF1V1CIr9tWa1sDQ=;
        b=EvK+Z/hVsEh+7/yI1lqIud4/JmX9WlWsZpP0OFOYL4oQqDcf3odGurG7HJDVIg6PU5
         T5/Ua0tIWaOdHC1B7WtqfUc/QAT3T/9LW67gjZuh8AaX5SzSM+ybSq2EZ+GHwR34XymN
         Rxi5+BaSXe6bGyd4ju1Irum4/rI/OCQfFp5IYGEbgka9x5Y13zKOkZyaB7MuRUU/EBZe
         YwU0V/48kBCeg95aNP2E6aW3Mt/swQivqsHW81hb3rDLElpcdIHxQ0rUvtyAx61+sGLi
         UbTBYNH//5fx+Ygwzlb4d99Xj2Jo/YyPiTEtO/0G6LkrC73RWtQB43fkqlcLuo+8erKB
         5XaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmzy4DS+P+lAWSvxAMhD16PJvNjh435nju8PJ6VLQ2CPt14HNjK6ZZ/QS3cXh6XA4W9j18O4EgBAQbdyIo+edudAR25jA=
X-Gm-Message-State: AOJu0YyXM5SLvRLxDTDeEvMTPOxlLNEuJQIcIpVF57p2k20Kfqs5n9E+
	IkBYKsCG4HBcSN7YqAEpcDoILUW7a0qTOePpqy515aCFWwHaMotLXI2ET2GhQFP7sK2AiqWeXDA
	p6gq88d3rn4o/siQy5IGzcktvZz7uRT9ZwKnE
X-Google-Smtp-Source: AGHT+IFjiqllbtZbfh6H7hOfR01xf4G8PNDyn1RyHhO2ITzkhGOqhIPLS7VFIHAGqVDoJDMdk8WysOY4o+NEDwrxuHA=
X-Received: by 2002:a05:690c:ec5:b0:64b:7500:2e9 with SMTP id
 00721157ae682-6b1b759714bmr105555907b3.9.1724001779618; Sun, 18 Aug 2024
 10:22:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1722665314-21156-1-git-send-email-wufan@linux.microsoft.com>
 <1722665314-21156-13-git-send-email-wufan@linux.microsoft.com>
 <9dc30ca6-486c-4fa9-910d-ed1dc6da0e95@linux.microsoft.com>
 <CAHC9VhQrnu8Sj=XnDvg=wGTBxacvMSW6OJyG3-tpwrsbGat6vA@mail.gmail.com>
 <88695db-efc0-6cc6-13ee-fd7c2abe61c@redhat.com> <ac6e33b8-ec1f-494a-874f-9a16d3316fce@linux.microsoft.com>
In-Reply-To: <ac6e33b8-ec1f-494a-874f-9a16d3316fce@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 18 Aug 2024 13:22:48 -0400
Message-ID: <CAHC9VhSe0HkzX0gy5Oo+549wG9xqfeHmsveJqdR_xRcYtim+sA@mail.gmail.com>
Subject: Re: [PATCH v20 12/20] dm verity: expose root hash digest and
 signature data to LSMs
To: Fan Wu <wufan@linux.microsoft.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
	Alasdair Kergon <agk@redhat.com>, linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev, 
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 3:11=E2=80=AFPM Fan Wu <wufan@linux.microsoft.com> =
wrote:
> On 8/16/2024 6:35 AM, Mikulas Patocka wrote:

...

> >>>>
> >>>> +#ifdef CONFIG_SECURITY
> >>>> +     u8 *root_digest_sig;    /* signature of the root digest */
> >>>> +#endif /* CONFIG_SECURITY */
> >>>>        unsigned int salt_size;
> >>>>        sector_t data_start;    /* data offset in 512-byte sectors */
> >>>>        sector_t hash_start;    /* hash start in blocks */
> >>>> @@ -58,6 +61,9 @@ struct dm_verity {
> >>>>        bool hash_failed:1;     /* set if hash of any block failed */
> >>>>        bool use_bh_wq:1;       /* try to verify in BH wq before norm=
al work-queue */
> >>>>        unsigned int digest_size;       /* digest size for the curren=
t hash algorithm */
> >>>> +#ifdef CONFIG_SECURITY
> >>>> +     unsigned int sig_size;  /* root digest signature size */
> >>>> +#endif /* CONFIG_SECURITY */
> >>>>        unsigned int hash_reqsize; /* the size of temporary space for=
 crypto */
> >>>>        enum verity_mode mode;  /* mode for handling verification err=
ors */
> >>>>        unsigned int corrupted_errs;/* Number of errors for corrupted=
 blocks */
> >
> > Just nit-picking: I would move "unsigned int sig_size" up, after "u8
> > *root_digest_sig" entry.
> >
> > Mikulas
>
> Sure, I can make these two fields together.

Fan, do you want me to move the @sig_size field when merging or are
you planning to submit another revision?  I'm happy to do it during
the merge, but I don't want to bother if you are going to post another
patchset.

--=20
paul-moore.com
